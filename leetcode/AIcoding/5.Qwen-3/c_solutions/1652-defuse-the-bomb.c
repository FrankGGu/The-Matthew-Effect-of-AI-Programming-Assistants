#include <stdio.h>
#include <stdlib.h>

int* decrypt(int* code, int codeSize, int k, int* returnSize) {
    int* result = (int*)malloc(codeSize * sizeof(int));
    for (int i = 0; i < codeSize; i++) {
        int sum = 0;
        if (k > 0) {
            for (int j = 1; j <= k; j++) {
                sum += code[(i + j) % codeSize];
            }
        } else if (k < 0) {
            for (int j = -1; j >= k; j--) {
                sum += code[(i + j + codeSize) % codeSize];
            }
        }
        result[i] = sum;
    }
    *returnSize = codeSize;
    return result;
}