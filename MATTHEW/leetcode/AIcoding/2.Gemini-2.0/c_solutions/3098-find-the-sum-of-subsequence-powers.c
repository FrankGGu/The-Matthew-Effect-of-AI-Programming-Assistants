#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

int sumSubsequencePowers(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), cmp);
    long long ans = 0;
    long long pow_k = 1;
    long long mod = 1e9 + 7;
    long long sum = 0;

    for (int i = numsSize - 1; i >= 0; i--) {
        ans = (ans + (long long)nums[i] * pow_k % mod) % mod;
        pow_k = (pow_k * 2) % mod;
    }

    return (int)ans;
}