#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long continuousSubarrays(int* nums, int numsSize) {
    long long count = 0;
    int left = 0;
    for (int right = 0; right < numsSize; right++) {
        while (1) {
            int min_val = nums[left];
            int max_val = nums[left];
            for (int i = left; i <= right; i++) {
                if (nums[i] < min_val) {
                    min_val = nums[i];
                }
                if (nums[i] > max_val) {
                    max_val = nums[i];
                }
            }
            if (max_val - min_val <= 2) {
                break;
            } else {
                left++;
            }
        }
        count += (right - left + 1);
    }
    return count;
}