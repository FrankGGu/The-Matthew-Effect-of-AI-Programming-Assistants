#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minGroups(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), [](const void *a, const void *b) {
        return *(int*)a - *(int*)b;
    });

    int groups = 0;
    int left = 0;
    int right = numsSize - 1;

    while (left <= right) {
        groups++;
        if (left == right) {
            break;
        }
        if (nums[right] - nums[left] <= k) {
            left++;
            right--;
        } else {
            right--;
        }
    }

    return groups;
}