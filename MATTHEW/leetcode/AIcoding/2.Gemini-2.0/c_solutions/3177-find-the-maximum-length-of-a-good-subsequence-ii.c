#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int solve(int* nums, int numsSize, int k, int index, long long prev, int count) {
    if (index == numsSize) {
        return count;
    }

    int take = 0;
    if (nums[index] % k == 0 || nums[index] > prev) {
        take = solve(nums, numsSize, k, index + 1, nums[index], count + 1);
    }

    int notTake = solve(nums, numsSize, k, index + 1, prev, count);

    return (take > notTake) ? take : notTake;
}

int longestGoodSubsequence(int* nums, int numsSize, int k) {
    return solve(nums, numsSize, k, 0, 0, 0);
}