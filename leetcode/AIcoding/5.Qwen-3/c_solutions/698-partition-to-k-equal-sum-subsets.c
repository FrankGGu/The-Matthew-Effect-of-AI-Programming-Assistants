#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool backtrack(int* nums, int numsSize, int* used, int currentSum, int target, int k, int start) {
    if (k == 0) return true;
    if (currentSum == target) return backtrack(nums, numsSize, used, 0, target, k - 1, 0);
    for (int i = start; i < numsSize; i++) {
        if (!used[i] && currentSum + nums[i] <= target) {
            used[i] = 1;
            if (backtrack(nums, numsSize, used, currentSum + nums[i], target, k, i + 1)) return true;
            used[i] = 0;
        }
    }
    return false;
}

bool canPartitionKSubsets(int* nums, int numsSize, int k) {
    int total = 0;
    for (int i = 0; i < numsSize; i++) total += nums[i];
    if (total % k != 0) return false;
    int target = total / k;
    int* used = (int*)malloc(numsSize * sizeof(int));
    memset(used, 0, numsSize * sizeof(int));
    return backtrack(nums, numsSize, used, 0, target, k, 0);
}