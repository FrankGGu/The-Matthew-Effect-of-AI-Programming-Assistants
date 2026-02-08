#include <stdio.h>
#include <stdlib.h>

#define MOD 1000000007

int numSubseq(int* nums, int numsSize, int target) {
    int* pow = (int*)malloc((numsSize + 1) * sizeof(int));
    pow[0] = 1;
    for (int i = 1; i <= numsSize; i++) {
        pow[i] = (pow[i - 1] * 2) % MOD;
    }

    qsort(nums, numsSize, sizeof(int), cmp);

    int left = 0, right = numsSize - 1, result = 0;
    while (left <= right) {
        if (nums[left] + nums[right] <= target) {
            result = (result + pow[right - left]) % MOD;
            left++;
        } else {
            right--;
        }
    }

    free(pow);
    return result;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}