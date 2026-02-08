#include <stdlib.h>

int* circularPermutation(int n, int start, int* returnSize) {
    int num_elements = 1 << n;
    *returnSize = num_elements;

    int* result = (int*)malloc(num_elements * sizeof(int));
    if (result == NULL) {
        return NULL;
    }

    for (int i = 0; i < num_elements; ++i) {
        result[i] = start ^ (i ^ (i >> 1));
    }

    return result;
}