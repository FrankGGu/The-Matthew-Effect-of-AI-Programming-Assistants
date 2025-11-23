#include <stdio.h>
#include <stdlib.h>

long long maximumSum(long long* nums, int numsSize, int k) {
    long long sum = 0;
    for (int i = 0; i < k; i++) {
        long long maxVal = nums[0];
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