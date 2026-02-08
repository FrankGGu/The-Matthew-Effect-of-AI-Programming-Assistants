#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

int purchasePlans(int* nums, int numsSize, int target) {
    qsort(nums, numsSize, sizeof(int), cmp);
    int left = 0, right = numsSize - 1;
    long long count = 0;
    while (left < right) {
        if (nums[left] + nums[right] <= target) {
            count = (count + (right - left)) % 1000000007;
            left++;
        } else {
            right--;
        }
    }
    return (int)count;
}