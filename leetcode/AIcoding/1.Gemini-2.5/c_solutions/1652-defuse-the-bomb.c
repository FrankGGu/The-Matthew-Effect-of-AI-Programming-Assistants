#include <stdlib.h>

int* defuseBomb(int* code, int codeSize, int k, int* returnSize) {
    int* result = (int*)malloc(codeSize * sizeof(int));
    *returnSize = codeSize;

    if (k == 0) {
        for (int i = 0; i < codeSize; i++) {
            result[i] = 0;
        }
        return result;
    }

    if (k > 0) {
        for (int i = 0; i < codeSize; i++) {
            int currentSum = 0;
            for (int j = 1; j <= k; j++) {
                currentSum += code[(i + j) % codeSize];
            }
            result[i] = currentSum;
        }
    } else { // k < 0
        int abs_k = -k;
        for (int i = 0; i < codeSize; i++) {
            int currentSum = 0;
            for (int j = 1; j <= abs_k; j++) {
                currentSum += code[(i - j + codeSize) % codeSize];
            }
            result[i] = currentSum;
        }
    }

    return result;
}