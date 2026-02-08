#include <stdio.h>
#include <stdlib.h>

int* getModifiedArray(int length, int** updates, int updatesSize, int* updatesColSize, int* returnSize) {
    int* result = (int*)calloc(length, sizeof(int));
    for (int i = 0; i < updatesSize; i++) {
        int start = updates[i][0];
        int end = updates[i][1];
        int inc = updates[i][2];
        result[start] += inc;
        if (end + 1 < length) {
            result[end + 1] -= inc;
        }
    }
    for (int i = 1; i < length; i++) {
        result[i] += result[i - 1];
    }
    *returnSize = length;
    return result;
}