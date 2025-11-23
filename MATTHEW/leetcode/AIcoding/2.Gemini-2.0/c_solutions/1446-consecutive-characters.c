#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxPower(char * s){
    int max = 1;
    int count = 1;
    for(int i = 1; s[i] != '\0'; i++){
        if(s[i] == s[i-1]){
            count++;
            if(count > max){
                max = count;
            }
        }
        else{
            count = 1;
        }
    }
    return max;
}