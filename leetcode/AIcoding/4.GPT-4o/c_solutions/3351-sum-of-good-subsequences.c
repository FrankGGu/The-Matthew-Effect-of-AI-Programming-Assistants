#include <stdio.h>
#include <stdlib.h>

#define MOD 1000000007

int sumOfGoodSubsequences(int* nums, int numsSize) {
    long long totalSum = 0;
    long long currentSum = 0;
    long long factor = 1;

    for (int i = 0; i < numsSize; i++) {
        currentSum = (currentSum * 2 + nums[i]) % MOD;
        totalSum = (totalSum + currentSum) % MOD;
    }

    return (int)totalSum;
}