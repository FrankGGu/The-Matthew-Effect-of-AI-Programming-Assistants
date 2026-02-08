#include <stdio.h>
#include <stdlib.h>

int* getDataframeSize(int** data, int dataSize, int* dataColSize, int* returnSize) {
    *returnSize = 2;
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = dataSize;
    result[1] = dataSize > 0 ? dataColSize[0] : 0;
    return result;
}