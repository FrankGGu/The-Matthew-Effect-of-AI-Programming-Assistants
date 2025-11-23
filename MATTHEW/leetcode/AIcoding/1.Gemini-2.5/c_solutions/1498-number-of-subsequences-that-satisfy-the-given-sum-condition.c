#include <stdlib.h>

int compareIntegers(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int numSubseq(int* nums, int numsSize, int target) {
    qsort(nums, numsSize, sizeof(int), compareIntegers);

    long long MOD = 1000000007;

    long long* powers = (long long*)malloc(sizeof(long long) * numsSize);
    powers[0] = 1;
    for (int i = 1; i < numsSize; i++) {
        powers[i] = (powers[i - 1] * 2) % MOD;
    }

    long long ans = 0;
    int left = 0;
    int right = numsSize - 1;

    while (left <= right) {
        if (nums[left] + nums[right] <= target) {
            ans = (ans + powers[right - left]) % MOD;
            left++;
        } else {
            right--;
        }
    }

    free(powers);
    return (int)ans;
}