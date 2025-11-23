#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numSubarrayProductLessThanK(int* nums, int numsSize, int k) {
    if (k <= 1) return 0;
    int count = 0;
    int product = 1;
    int left = 0;
    for (int right = 0; right < numsSize; right++) {
        product *= nums[right];
        while (product >= k) {
            product /= nums[left];
            left++;
        }
        count += right - left + 1;
    }
    return count;
}