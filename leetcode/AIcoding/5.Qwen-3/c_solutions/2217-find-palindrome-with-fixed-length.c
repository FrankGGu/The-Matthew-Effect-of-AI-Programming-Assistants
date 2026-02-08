#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* getPalindrome(int n, int k) {
    char* result = (char*)malloc((n + 1) * sizeof(char));
    int half = (n + 1) / 2;
    int i;

    for (i = 0; i < half; i++) {
        result[i] = '0' + (k % 10);
        k /= 10;
    }

    for (i = 0; i < half; i++) {
        result[n - 1 - i] = result[i];
    }

    result[n] = '\0';
    return result;
}