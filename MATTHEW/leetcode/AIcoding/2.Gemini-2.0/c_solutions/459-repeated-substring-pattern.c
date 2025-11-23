#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool repeatedSubstringPattern(char * s){
    int n = strlen(s);
    for (int i = 1; i <= n / 2; i++) {
        if (n % i == 0) {
            int num_repeats = n / i;
            char substring[i + 1];
            strncpy(substring, s, i);
            substring[i] = '\0';

            bool repeated = true;
            for (int j = 1; j < num_repeats; j++) {
                if (strncmp(s + j * i, substring, i) != 0) {
                    repeated = false;
                    break;
                }
            }

            if (repeated) {
                return true;
            }
        }
    }
    return false;
}