#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sumSubseqWidths(int* nums, int numsSize){
    const int MOD = 1000000007;
    long long ans = 0;
    long long p = 1;

    qsort(nums, numsSize, sizeof(int), (int (*)(const void *, const void *))compare);

    for (int i = 0; i < numsSize; i++) {
        ans = (ans + (long long)nums[i] * (p - 1)) % MOD;
        ans = (ans - (long long)nums[numsSize - 1 - i] * (p - 1)) % MOD;

        p = (p * 2) % MOD;
    }

    return (ans + MOD) % MOD;
}

int compare (const void * a, const void * b)
{
  return ( *(int*)a - *(int*)b );
}