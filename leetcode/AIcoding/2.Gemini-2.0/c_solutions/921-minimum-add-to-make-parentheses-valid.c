#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minAddToMakeValid(char * s){
    int open = 0;
    int close = 0;
    for(int i = 0; s[i] != '\0'; i++){
        if(s[i] == '('){
            open++;
        } else {
            if(open > 0){
                open--;
            } else {
                close++;
            }
        }
    }
    return open + close;
}