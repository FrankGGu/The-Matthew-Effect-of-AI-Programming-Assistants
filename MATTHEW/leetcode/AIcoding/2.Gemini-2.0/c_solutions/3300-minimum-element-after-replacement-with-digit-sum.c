#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int digitSum(int n) {
    int sum = 0;
    while (n > 0) {
        sum += n % 10;
        n /= 10;
    }
    return sum;
}

int minimizeArrayValue(int* nums, int numsSize) {
    for (int i = 0; i < numsSize; i++) {
        while (nums[i] >= 10) {
            int sum = digitSum(nums[i]);
            nums[i] = sum;
        }
    }

    int minVal = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < minVal) {
            minVal = nums[i];
        }
    }
    return minVal;
}