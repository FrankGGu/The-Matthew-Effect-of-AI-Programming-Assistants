#include <stdio.h>
#include <stdlib.h>

int arithmeticTriplets(int* nums, int numsSize, int target) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            for (int k = j + 1; k < numsSize; k++) {
                if (nums[j] - nums[i] == nums[k] - nums[j] && nums[j] - nums[i] == target) {
                    count++;
                }
            }
        }
    }
    return count;
}