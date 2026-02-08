#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkZeroOnes(char * s){
    int ones = 0;
    int zeros = 0;
    int current_ones = 0;
    int current_zeros = 0;

    for(int i = 0; s[i] != '\0'; i++){
        if(s[i] == '1'){
            current_ones++;
            current_zeros = 0;
        } else {
            current_zeros++;
            current_ones = 0;
        }

        if(current_ones > ones){
            ones = current_ones;
        }
        if(current_zeros > zeros){
            zeros = current_zeros;
        }
    }

    return ones > zeros;
}