#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int subarrayBitwiseORs(int* A, int ASize, int* returnSize) {
    int* result = (int*)malloc(ASize * sizeof(int));
    int* current = (int*)malloc(ASize * sizeof(int));
    int count = 0;
    int curIndex = 0;

    for (int i = 0; i < ASize; i++) {
        int newSize = 0;
        current[newSize++] = A[i];
        for (int j = 0; j < count; j++) {
            int val = current[j] | A[i];
            if (newSize == 0 || val != current[newSize - 1]) {
                current[newSize++] = val;
            }
        }
        count = newSize;
        for (int j = 0; j < newSize; j++) {
            if (!result[j]) {
                result[j] = current[j];
            }
        }
    }

    *returnSize = count;
    free(current);
    return result;
}