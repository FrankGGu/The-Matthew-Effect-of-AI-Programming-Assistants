#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numSubarraysWithSum(int* nums, int numsSize, int goal) {
    int count = 0;
    int sum = 0;
    int left = 0;
    int right = 0;
    int leftBound = 0;

    while (right < numsSize) {
        sum += nums[right];

        while (sum > goal) {
            sum -= nums[left];
            left++;
            leftBound = left;
        }

        if (sum == goal) {
            leftBound = left;
            while (leftBound < right && nums[leftBound] == 0) {
                leftBound++;
            }
            count += (leftBound - left + 1);
        }
        right++;
    }

    return count;
}