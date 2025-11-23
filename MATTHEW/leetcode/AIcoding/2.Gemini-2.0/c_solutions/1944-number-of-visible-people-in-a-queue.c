#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* canSeePersonsCount(int* heights, int heightsSize, int* returnSize){
    int *result = (int*)malloc(sizeof(int) * heightsSize);
    *returnSize = heightsSize;

    for (int i = 0; i < heightsSize; i++) {
        int count = 0;
        int max_height = -1;
        for (int j = i + 1; j < heightsSize; j++) {
            if (heights[j] > max_height) {
                count++;
                max_height = heights[j];
            }
            if (heights[j] > heights[i]) {
                break;
            }
        }
        result[i] = count;
    }

    return result;
}