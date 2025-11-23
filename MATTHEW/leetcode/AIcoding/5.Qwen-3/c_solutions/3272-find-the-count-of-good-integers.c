#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countGoodIntegers(char* s) {
    int count = 0;
    int n = strlen(s);
    for (int i = 0; i < n - 2; i++) {
        if (s[i] == s[i + 1] && s[i + 1] == s[i + 2]) {
            count++;
        }
    }
    return count;
}