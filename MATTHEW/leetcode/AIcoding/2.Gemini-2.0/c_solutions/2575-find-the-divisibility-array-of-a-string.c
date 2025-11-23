#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* divisibilityArray(char * word, int m, int* returnSize) {
    int n = strlen(word);
    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    long long remainder = 0;
    for (int i = 0; i < n; i++) {
        remainder = (remainder * 10 + (word[i] - '0')) % m;
        if (remainder == 0) {
            result[i] = 1;
        } else {
            result[i] = 0;
        }
    }

    return result;
}