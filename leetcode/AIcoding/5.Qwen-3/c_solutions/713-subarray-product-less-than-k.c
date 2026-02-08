#include <stdio.h>
#include <stdlib.h>

int numSubarrayProductLessThanK(int* nums, int numsSize, int k) {
    if (k <= 1) return 0;
    int count = 0, left = 0, product = 1;
    for (int right = 0; right < numsSize; right++) {
        product *= nums[right];
        while (product >= k) {
            product /= nums[left++];
        }
        count += right - left + 1;
    }
    return count;
}