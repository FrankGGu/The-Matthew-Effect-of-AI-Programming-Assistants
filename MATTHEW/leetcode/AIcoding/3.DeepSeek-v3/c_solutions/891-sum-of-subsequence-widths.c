#include <stdlib.h>
#include <string.h>

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int sumSubseqWidths(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), cmp);

    long long mod = 1000000007;
    long long* pow2 = (long long*)malloc(numsSize * sizeof(long long));
    pow2[0] = 1;
    for (int i = 1; i < numsSize; i++) {
        pow2[i] = (pow2[i-1] * 2) % mod;
    }

    long long res = 0;
    for (int i = 0; i < numsSize; i++) {
        res = (res + nums[i] * pow2[i] - nums[i] * pow2[numsSize - 1 - i]) % mod;
    }

    free(pow2);
    return (res % mod + mod) % mod;
}