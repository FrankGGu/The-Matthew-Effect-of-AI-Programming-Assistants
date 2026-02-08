#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sumOfBeauties(int* nums, int numsSize) {
    int sum = 0;
    for (int i = 1; i < numsSize - 1; i++) {
        int beauty = 0;
        int leftMax = nums[0];
        for (int j = 1; j < i; j++) {
            if (nums[j] > leftMax) {
                leftMax = nums[j];
            }
        }
        int rightMin = nums[numsSize - 1];
        for (int j = i + 1; j < numsSize; j++) {
            if (nums[j] < rightMin) {
                rightMin = nums[j];
            }
        }
        if (nums[i] > leftMax && nums[i] < rightMin) {
            beauty = 2;
        } else if (nums[i] > nums[i - 1] && nums[i] < nums[i + 1]) {
            beauty = 1;
        }
        sum += beauty;
    }
    return sum;
}