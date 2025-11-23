#include <stdio.h>
#include <stdlib.h>

int maxFrequency(int* nums, int numsSize, int k) {
    int left = 0;
    int maxFreq = 0;
    int sum = 0;
    for (int right = 0; right < numsSize; right++) {
        sum += nums[right];
        while (sum - nums[right] * (right - left + 1) > k) {
            sum -= nums[left];
            left++;
        }
        maxFreq = (maxFreq > (right - left + 1)) ? maxFreq : (right - left + 1);
    }
    return maxFreq;
}