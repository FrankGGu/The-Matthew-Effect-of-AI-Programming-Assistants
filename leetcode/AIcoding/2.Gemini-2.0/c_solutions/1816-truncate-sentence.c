#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * truncateSentence(char * s, int k){
    int len = strlen(s);
    int count = 0;
    for(int i = 0; i < len; i++){
        if(s[i] == ' '){
            count++;
            if(count == k){
                s[i] = '\0';
                break;
            }
        }
    }
    return s;
}