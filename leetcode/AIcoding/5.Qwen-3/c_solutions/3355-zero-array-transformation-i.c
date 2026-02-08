#include <stdio.h>
#include <stdlib.h>

bool checkArray(int* nums, int numsSize, int k) {
    int* diff = (int*)calloc(numsSize + 1, sizeof(int));
    int current = 0;
    for (int i = 0; i < numsSize; i++) {
        current += diff[i];
        if (nums[i] != 0 && current == 0) return false;
        if (nums[i] - current > 0) {
            int val = nums[i] - current;
            current += val;
            if (i + k < numsSize) diff[i + k] -= val;
        }
    }
    free(diff);
    return true;
}