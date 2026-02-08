#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** largeGroupPositions(char* s, int* returnSize, int** returnColumnSizes) {
    int n = strlen(s);
    int** result = (int**)malloc(sizeof(int*) * (n / 3 + 1));
    *returnColumnSizes = (int*)malloc(sizeof(int) * (n / 3 + 1));
    *returnSize = 0;

    int start = 0;
    for (int i = 1; i <= n; i++) {
        if (i == n || s[i] != s[start]) {
            if (i - start >= 3) {
                result[*returnSize] = (int*)malloc(sizeof(int) * 2);
                result[*returnSize][0] = start;
                result[*returnSize][1] = i - 1;
                (*returnColumnSizes)[*returnSize] = 2;
                (*returnSize)++;
            }
            start = i;
        }
    }

    return result;
}