#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long subArrayRanges(int* nums, int numsSize) {
    long long sum = 0;
    for (int i = 0; i < numsSize; i++) {
        int minVal = nums[i];
        int maxVal = nums[i];
        for (int j = i + 1; j < numsSize; j++) {
            if (nums[j] < minVal) {
                minVal = nums[j];
            }
            if (nums[j] > maxVal) {
                maxVal = nums[j];
            }
            sum += (long long)(maxVal - minVal);
        }
    }
    return sum;
}