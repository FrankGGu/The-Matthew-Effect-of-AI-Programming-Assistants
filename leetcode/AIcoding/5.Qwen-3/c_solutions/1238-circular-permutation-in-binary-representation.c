#include <stdio.h>
#include <stdlib.h>

int* circularPermutation(int n, int start, int* returnSize) {
    *returnSize = 1 << n;
    int* result = (int*)malloc(*returnSize * sizeof(int));
    for (int i = 0; i < *returnSize; i++) {
        result[i] = i ^ (i >> 1);
    }
    int index = 0;
    for (int i = 0; i < *returnSize; i++) {
        if (result[i] == start) {
            index = i;
            break;
        }
    }
    int* rotated = (int*)malloc(*returnSize * sizeof(int));
    for (int i = 0; i < *returnSize; i++) {
        rotated[i] = result[(index + i) % *returnSize];
    }
    free(result);
    return rotated;
}