#include <stdio.h>
#include <stdlib.h>

int* fairCandySwap(int* A, int ASize, int* B, int BSize, int* returnSize) {
    int sumA = 0, sumB = 0;
    for (int i = 0; i < ASize; i++) sumA += A[i];
    for (int i = 0; i < BSize; i++) sumB += B[i];

    int delta = (sumA - sumB) / 2;

    int* hash = (int*)calloc(10001, sizeof(int));
    for (int i = 0; i < BSize; i++) hash[B[i]] = 1;

    for (int i = 0; i < ASize; i++) {
        if (hash[A[i] - delta]) {
            int* result = (int*)malloc(2 * sizeof(int));
            result[0] = A[i];
            result[1] = A[i] - delta;
            *returnSize = 2;
            free(hash);
            return result;
        }
    }

    free(hash);
    *returnSize = 0;
    return NULL;
}