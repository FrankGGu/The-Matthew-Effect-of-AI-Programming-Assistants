#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minPairSum(int* nums, int numsSize) {
    int max_sum = 0;
    qsort(nums, numsSize, sizeof(int), compare);
    for (int i = 0; i < numsSize / 2; i++) {
        int sum = nums[i] + nums[numsSize - 1 - i];
        if (sum > max_sum) {
            max_sum = sum;
        }
    }
    return max_sum;
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int minOperations(int* nums, int numsSize) {
    int n = numsSize;
    int count = 0;
    int left = 0;
    int right = n - 1;

    while (left < right) {
        if (nums[left] > nums[left + 1]) {
            left++;
            count++;
            continue;
        }
        if (nums[right] < nums[right - 1]) {
            right--;
            count++;
            continue;
        }
        if (nums[left] > nums[right]) {
            left++;
            right--;
            count++;
            continue;
        }
        left++;
        right--;
    }

    return count;
}