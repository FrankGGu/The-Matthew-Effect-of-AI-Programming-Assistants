#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubstrings(char * s){
    int n = 0;
    while(s[n] != '\0'){
        n++;
    }
    int count = 0;
    for(int i = 0; i < n; i++){
        for(int j = i; j < n; j++){
            long long num = 0;
            for(int k = i; k <= j; k++){
                num = num * 10 + (s[k] - '0');
            }
            int lastDigit = s[j] - '0';
            if(lastDigit != 0 && num % lastDigit == 0){
                count++;
            }
        }
    }
    return count;
}