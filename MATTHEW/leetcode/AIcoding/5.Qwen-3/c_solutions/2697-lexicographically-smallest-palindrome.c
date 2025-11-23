#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* makeSmallestPalindrome(char* s) {
    int n = strlen(s);
    char* result = (char*)malloc((n + 1) * sizeof(char));
    strcpy(result, s);

    for (int i = 0; i < n / 2; i++) {
        if (result[i] != result[n - 1 - i]) {
            if (result[i] < result[n - 1 - i]) {
                result[n - 1 - i] = result[i];
            } else {
                result[i] = result[n - 1 - i];
            }
        }
    }

    return result;
}