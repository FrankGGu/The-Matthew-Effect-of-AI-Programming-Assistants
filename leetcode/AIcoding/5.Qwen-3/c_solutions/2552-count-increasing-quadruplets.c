#include <stdio.h>
#include <stdlib.h>

int countQuadruplets(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            for (int k = j + 1; k < numsSize; k++) {
                for (int l = k + 1; l < numsSize; l++) {
                    if (nums[i] < nums[j] && nums[j] < nums[k] && nums[k] < nums[l]) {
                        count++;
                    }
                }
            }
        }
    }
    return count;
}