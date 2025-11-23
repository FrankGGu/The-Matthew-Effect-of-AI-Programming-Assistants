#include <stdlib.h>

long long power(long long base, long long exp) {
    long long res = 1;
    long long MOD = 1000000007;
    base %= MOD;
    while (exp > 0) {
        if (exp % 2 == 1) res = (res * base) % MOD;
        base = (base * base) % MOD;
        exp /= 2;
    }
    return res;
}

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int countGoodPartitions(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 1;
    }

    qsort(nums, numsSize, sizeof(int), compare);

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] == nums[i-1]) {
            return 0;
        }
    }

    return (int)power(2, numsSize - 1);
}