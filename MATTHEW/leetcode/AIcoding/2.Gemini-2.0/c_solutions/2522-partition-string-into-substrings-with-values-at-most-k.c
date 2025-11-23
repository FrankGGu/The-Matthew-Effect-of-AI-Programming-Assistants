#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int partitionString(char * s, int k){
    int count = 1;
    long long current_val = 0;
    for (int i = 0; i < strlen(s); i++) {
        int digit = s[i] - '0';
        if (digit > k) {
            return -1; 
        }
        if (current_val * 10 + digit <= k) {
            current_val = current_val * 10 + digit;
        } else {
            count++;
            current_val = digit;
        }
    }
    return count;
}