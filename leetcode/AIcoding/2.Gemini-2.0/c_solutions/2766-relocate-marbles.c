#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* relocateMarbles(int* nums, int numsSize, int* moveFrom, int moveFromSize, int* moveTo, int moveToSize, int* returnSize){
    bool *present = calloc(200001, sizeof(bool));
    for (int i = 0; i < numsSize; i++) {
        present[nums[i] + 100000] = true;
    }

    for (int i = 0; i < moveFromSize; i++) {
        if (present[moveFrom[i] + 100000]) {
            present[moveFrom[i] + 100000] = false;
            present[moveTo[i] + 100000] = true;
        }
    }

    int count = 0;
    for (int i = 0; i < 200001; i++) {
        if (present[i]) {
            count++;
        }
    }

    int *result = malloc(count * sizeof(int));
    int index = 0;
    for (int i = 0; i < 200001; i++) {
        if (present[i]) {
            result[index++] = i - 100000;
        }
    }

    *returnSize = count;
    free(present);
    return result;
}