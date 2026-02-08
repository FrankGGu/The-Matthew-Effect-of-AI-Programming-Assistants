#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numSubarrayProductLessThanK(int* nums, int numsSize, int k) {
    if (k <= 1) return 0;
    int left = 0;
    int prod = 1;
    int count = 0;
    for (int right = 0; right < numsSize; right++) {
        prod *= nums[right];
        while (prod >= k) {
            prod /= nums[left];
            left++;
        }
        count += right - left + 1;
    }
    return count;
}