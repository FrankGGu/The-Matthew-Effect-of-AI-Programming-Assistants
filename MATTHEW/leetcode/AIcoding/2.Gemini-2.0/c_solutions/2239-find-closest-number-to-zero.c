#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findClosestNumber(int* nums, int numsSize){
    int closest = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (abs(nums[i]) < abs(closest)) {
            closest = nums[i];
        } else if (abs(nums[i]) == abs(closest)) {
            if (nums[i] > closest) {
                closest = nums[i];
            }
        }
    }
    return closest;
}