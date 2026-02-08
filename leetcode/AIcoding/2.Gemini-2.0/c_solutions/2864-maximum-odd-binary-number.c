#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * maximumOddBinaryNumber(char * s){
    int ones = 0;
    int len = strlen(s);
    for(int i = 0; i < len; i++){
        if(s[i] == '1')
            ones++;
    }
    for(int i = 0; i < len; i++){
        s[i] = '0';
    }
    for(int i = 0; i < ones - 1; i++){
        s[i] = '1';
    }
    s[len - 1] = '1';
    return s;
}