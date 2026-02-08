#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** largeGroupPositions(char * s, int* returnSize, int** returnColumnSizes){
    int n = strlen(s);
    *returnSize = 0;
    *returnColumnSizes = (int*)malloc(sizeof(int) * n);
    int** result = (int**)malloc(sizeof(int*) * n);

    int i = 0;
    while (i < n) {
        int j = i;
        while (j < n && s[j] == s[i]) {
            j++;
        }
        if (j - i >= 3) {
            result[*returnSize] = (int*)malloc(sizeof(int) * 2);
            result[*returnSize][0] = i;
            result[*returnSize][1] = j - 1;
            (*returnColumnSizes)[*returnSize] = 2;
            (*returnSize)++;
        }
        i = j;
    }

    return result;
}