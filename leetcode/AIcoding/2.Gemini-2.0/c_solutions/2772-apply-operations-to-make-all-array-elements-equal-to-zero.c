#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkArray(int* nums, int numsSize, int k){
    int* diff = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        diff[i] = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        if (diff[i] + nums[i] < 0) {
            free(diff);
            return false;
        }

        int val = diff[i] + nums[i];
        if (val == 0) continue;

        if (i + k > numsSize) {
            free(diff);
            return false;
        }

        for (int j = i; j < i + k; j++) {
            diff[j] -= val;
        }
    }

    free(diff);
    return true;
}