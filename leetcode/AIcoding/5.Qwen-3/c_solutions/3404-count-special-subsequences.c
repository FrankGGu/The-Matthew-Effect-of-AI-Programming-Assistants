#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSpecialSubsequences(char* s) {
    long countA = 0, countB = 0, countC = 0;
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        if (s[i] == 'a') {
            countA = (countA * 2) + 1;
        } else if (s[i] == 'b') {
            countB = (countB * 2) + countA;
        } else if (s[i] == 'c') {
            countC = (countC * 2) + countB;
        }
    }
    return (int)countC;
}