import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberValidationWidget extends StatefulWidget {
  const PhoneNumberValidationWidget
({Key? key}) : super(key: key);

  @override
  State<PhoneNumberValidationWidget> createState() => _PhoneNumberValidationWidgetState();
  
}

class _PhoneNumberValidationWidgetState extends State<PhoneNumberValidationWidget> {
   
  final  _controller = TextEditingController();
  int charLength = 0;
  
  void _clearTextField() {
  
    _controller.clear();
  
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      body: Center(
        child:Padding(
          padding: const EdgeInsets.fromLTRB(15, 40, 15, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
      children:  [
         const SizedBox(height: 70),
      const Text("Get Started",
      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
    
      const SizedBox(height: 150),
      TextFormField(
        controller: _controller,
        onChanged: (value) {
          setState(() {
            
          });
        },
          decoration:  InputDecoration(
            hintText: '(201) 555-0123',
            helperText: 'Enter your phone number',
            suffixIcon: _controller.text.isEmpty ? null :	IconButton(
              
            onPressed:_clearTextField,
            icon: const Icon(Icons.clear))
            
          ),
          keyboardType: TextInputType.phone,
          autofocus: true,
          inputFormatters: [ 
          
            PhoneNumberFormatter(),
            FilteringTextInputFormatter.allow(RegExp(r'^[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')),
            LengthLimitingTextInputFormatter(14)

          ],
      ),
      const SizedBox(height: 20,),
     
      Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton(
          onPressed: _controller.text.length ==14 ? (){ 
           showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
         
          content: Text(_controller.text),
        );
      },
   
        );
          } : null,
          
          
          style:ElevatedButton.styleFrom(shape: const CircleBorder(),padding: const EdgeInsets.all(15)),
          
          child: const Icon(Icons.arrow_right_alt,),
          ),
      )
      ],
    
          ),
        )
      ),

      
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  
 
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  
  ) {
     
    
    
   
    var newText = newValue.text;
    if ( oldValue.text.endsWith(') ') &&
        oldValue.text.length == newValue.text.length + 1) {
      newText = newText.substring(0, newText.length - 2);
      return TextEditingValue(
        text: newText.toString(),
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }

    if ( oldValue.text.endsWith('-') &&
        oldValue.text.length == newValue.text.length + 1) {
      newText = newText.substring(0, newText.length - 1);
      return TextEditingValue(
        text: newText.toString(),
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
   
   
    if (newText.length == 1) newText ="(" + newText;
    if (newText.length == 4) newText = newText + ") ";
    if (newText.length == 9) newText = newText + "-";
 
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

