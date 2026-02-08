#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkString(char * s){
    bool b_found = false;
    for(int i = 0; s[i] != '\0'; i++){
        if(s[i] == 'b'){
            b_found = true;
        } else if (s[i] == 'a' && b_found){
            return false;
        }
    }
    return true;
}