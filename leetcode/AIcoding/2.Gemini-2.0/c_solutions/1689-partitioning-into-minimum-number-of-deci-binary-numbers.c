#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minPartitions(char * n){
    int maxDigit = 0;
    for (int i = 0; n[i] != '\0'; i++) {
        int digit = n[i] - '0';
        if (digit > maxDigit) {
            maxDigit = digit;
        }
    }
    return maxDigit;
}