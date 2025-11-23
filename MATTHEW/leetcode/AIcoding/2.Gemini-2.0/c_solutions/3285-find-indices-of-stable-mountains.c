#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findValleyIndices(int* height, int heightSize, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 0;

    if (heightSize < 3) {
        return result;
    }

    for (int i = 1; i < heightSize - 1; i++) {
        if (height[i] < height[i - 1] && height[i] < height[i + 1]) {
            result[0] = i - 1;
            result[1] = i + 1;
            *returnSize = 2;
            return result;
        }
    }

    return result;
}