#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countGoodSubstrings(char* s) {
    int count = 0;
    int len = strlen(s);
    for (int i = 0; i <= len - 3; i++) {
        if (s[i] != s[i+1] && s[i] != s[i+2] && s[i+1] != s[i+2]) {
            count++;
        }
    }
    return count;
}