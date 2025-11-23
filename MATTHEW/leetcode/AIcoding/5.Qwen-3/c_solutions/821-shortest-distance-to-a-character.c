#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* shortestToChar(char* s, int targetIndex, int* returnSize) {
    int n = strlen(s);
    int* result = (int*)malloc(n * sizeof(int));
    int prev = -n;

    for (int i = 0; i < n; i++) {
        if (s[i] == s[targetIndex]) {
            prev = i;
        }
        result[i] = i - prev;
    }

    prev = 2 * n;
    for (int i = n - 1; i >= 0; i--) {
        if (s[i] == s[targetIndex]) {
            prev = i;
        }
        result[i] = fmin(result[i], prev - i);
    }

    *returnSize = n;
    return result;
}