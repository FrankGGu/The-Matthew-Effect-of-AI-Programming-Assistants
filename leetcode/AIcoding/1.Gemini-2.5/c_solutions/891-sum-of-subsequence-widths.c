#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int sumSubseqWidths(int* nums, int numsSize) {
    const int MOD = 1000000007;

    qsort(nums, numsSize, sizeof(int), compare);

    long long *pow2 = (long long *)malloc(numsSize * sizeof(long long));

    pow2[0] = 1;
    for (int i = 1; i < numsSize; i++) {
        pow2[i] = (pow2[i-1] * 2) % MOD;
    }

    long long total_sum = 0;
    for (int i = 0; i < numsSize; i++) {
        long long max_contribution = ((long long)nums[i] * pow2[i]) % MOD;
        long long min_contribution = ((long long)nums[i] * pow2[numsSize - 1 - i]) % MOD;

        total_sum = (total_sum + max_contribution - min_contribution + MOD) % MOD;
    }

    free(pow2);

    return (int)total_sum;
}