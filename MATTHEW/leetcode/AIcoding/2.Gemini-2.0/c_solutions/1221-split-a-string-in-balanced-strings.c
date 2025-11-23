#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int balancedStringSplit(char * s){
    int count = 0;
    int balance = 0;
    for(int i = 0; s[i] != '\0'; i++){
        if(s[i] == 'L'){
            balance++;
        } else {
            balance--;
        }
        if(balance == 0){
            count++;
        }
    }
    return count;
}