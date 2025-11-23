#include <stdlib.h>

int* sortArrayByParity(int* A, int ASize, int* returnSize) {
    int* result = (int*)malloc(ASize * sizeof(int));
    int evenIndex = 0, oddIndex = ASize - 1;

    for (int i = 0; i < ASize; i++) {
        if (A[i] % 2 == 0) {
            result[evenIndex++] = A[i];
        } else {
            result[oddIndex--] = A[i];
        }
    }

    *returnSize = ASize;
    return result;
}