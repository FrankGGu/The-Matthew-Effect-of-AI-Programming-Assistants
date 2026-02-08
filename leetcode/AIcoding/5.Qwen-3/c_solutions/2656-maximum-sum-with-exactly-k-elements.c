#include <stdio.h>
#include <stdlib.h>

int maxSum(int* nums, int numsSize, int k) {
    int sum = 0;
    for (int i = 0; i < k; i++) {
        int maxVal = nums[0];
        int maxIndex = 0;
        for (int j = 1; j < numsSize; j++) {
            if (nums[j] > maxVal) {
                maxVal = nums[j];
                maxIndex = j;
            }
        }
        sum += maxVal;
        nums[maxIndex] = 0;
    }
    return sum;
}