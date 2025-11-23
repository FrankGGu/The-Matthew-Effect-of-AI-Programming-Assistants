#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int findPairs(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), compare);
    int count = 0;
    int left = 0;
    int right = 1;

    while (right < numsSize) {
        if (nums[right] - nums[left] == k) {
            count++;
            left++;
            right++;
            while (right < numsSize && nums[right] == nums[right - 1]) {
                right++;
            }
        } else if (nums[right] - nums[left] < k) {
            right++;
        } else {
            left++;
            if (left == right) {
                right++;
            }
        }
    }
    return count;
}