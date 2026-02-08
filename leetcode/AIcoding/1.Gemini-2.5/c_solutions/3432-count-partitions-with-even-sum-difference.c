#include <stddef.h> // For size_t

long long power(long long base, long long exp) {
    long long res = 1;
    long long MOD = 1000000007;
    base %= MOD;
    while (exp > 0) {
        if (exp % 2 == 1) {
            res = (res * base) % MOD;
        }
        base = (base * base) % MOD;
        exp /= 2;
    }
    return res;
}

int countPartitions(int* nums, int numsSize) {
    long long totalSum = 0;
    for (int i = 0; i < numsSize; i++) {
        totalSum += nums[i];
    }

    if (totalSum % 2 != 0) {
        return 0;
    } else {
        return (int)power(2, numsSize);
    }
}