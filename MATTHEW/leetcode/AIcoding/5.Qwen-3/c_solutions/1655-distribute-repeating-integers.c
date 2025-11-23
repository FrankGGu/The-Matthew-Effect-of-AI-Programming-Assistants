#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

bool *used;
int *count;
int n;
int m;

bool backtrack(int* nums, int numsSize, int pos, int k) {
    if (pos == numsSize) {
        return true;
    }
    for (int i = 0; i < n; i++) {
        if (used[i]) continue;
        if (count[i] == 0) continue;
        if (nums[pos] != nums[pos - 1] || !used[i - 1]) {
            used[i] = true;
            count[i]--;
            if (backtrack(nums, numsSize, pos + 1, k)) {
                return true;
            }
            count[i]++;
            used[i] = false;
        }
    }
    return false;
}

bool canPartitionKSubsets(int* nums, int numsSize, int k) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }
    if (sum % k != 0) return false;
    int target = sum / k;
    qsort(nums, numsSize, sizeof(int), (int (*)(const void*, const void*))strcmp);
    n = numsSize;
    m = target;
    used = (bool*)malloc(n * sizeof(bool));
    count = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        used[i] = false;
        count[i] = nums[i];
    }
    return backtrack(nums, numsSize, 0, k);
}