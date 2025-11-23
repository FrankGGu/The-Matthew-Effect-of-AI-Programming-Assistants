#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool divideArray(int* nums, int numsSize){
    if (numsSize % 2 != 0) return false;

    int* counts = (int*)malloc(sizeof(int) * 501);
    for (int i = 0; i < 501; i++) {
        counts[i] = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        counts[nums[i]]++;
    }

    for (int i = 0; i < 501; i++) {
        if (counts[i] % 2 != 0) {
            free(counts);
            return false;
        }
    }

    free(counts);
    return true;
}