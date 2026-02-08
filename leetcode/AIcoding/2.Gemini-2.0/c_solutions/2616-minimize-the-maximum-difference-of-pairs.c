#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

bool check(int mid, int *nums, int numsSize, int p) {
    int count = 0;
    for (int i = 0; i < numsSize - 1; i++) {
        if (nums[i+1] - nums[i] <= mid) {
            count++;
            i++;
        }
    }
    return count >= p;
}

int minimizeMax(int* nums, int numsSize, int p) {
    qsort(nums, numsSize, sizeof(int), cmp);
    int left = 0, right = nums[numsSize - 1] - nums[0];
    int ans = right;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (check(mid, nums, numsSize, p)) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }
    return ans;
}