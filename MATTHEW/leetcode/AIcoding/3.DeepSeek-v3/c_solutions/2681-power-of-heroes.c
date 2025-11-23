#include <stdlib.h>
#include <string.h>

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int sumOfPower(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), cmp);
    long long mod = 1000000007;
    long long res = 0, s = 0;
    for (int i = 0; i < numsSize; i++) {
        long long x = nums[i];
        res = (res + (x * x % mod) * (x + s) % mod) % mod;
        s = (s * 2 + x) % mod;
    }
    return res;
}