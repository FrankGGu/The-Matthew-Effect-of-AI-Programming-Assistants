#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countHomogenous(char * s){
    int count = 0;
    int current_len = 0;
    char current_char = '\0';
    int mod = 1000000007;

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == current_char) {
            current_len++;
        } else {
            current_char = s[i];
            current_len = 1;
        }
        count = (count + current_len) % mod;
    }

    return count;
}