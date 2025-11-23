#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmpfunc(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

int longestConsecutive(int* nums, int numsSize) {
    if (numsSize == 0) return 0;

    qsort(nums, numsSize, sizeof(int), cmpfunc);

    int max_len = 1;
    int curr_len = 1;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] == nums[i - 1]) {
            continue;
        } else if (nums[i] == nums[i - 1] + 1) {
            curr_len++;
        } else {
            max_len = (curr_len > max_len) ? curr_len : max_len;
            curr_len = 1;
        }
    }
    max_len = (curr_len > max_len) ? curr_len : max_len;

    return max_len;
}

int maxConsecutive(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), cmpfunc);

    int left = 0;
    int right = 0;
    int max_len = 0;
    int cost = 0;

    while (right < numsSize) {
        cost += (nums[right] - nums[right - 1]) * (right - left) * (right > 0);

        while (cost > k) {
            cost -= (nums[right] - nums[left]) ;
            left++;
        }

        max_len = (right - left + 1 > max_len) ? right - left + 1 : max_len;
        right++;
    }

    return max_len;
}