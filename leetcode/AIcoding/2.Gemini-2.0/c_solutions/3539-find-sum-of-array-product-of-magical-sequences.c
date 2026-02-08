#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int sumOfArrayProducts(int n, int* nums, int numsSize) {
    long long totalSum = 0;
    for (int i = 0; i < (1 << numsSize); i++) {
        if (__builtin_popcount(i) == n) {
            long long product = 1;
            for (int j = 0; j < numsSize; j++) {
                if ((i >> j) & 1) {
                    product = (product * nums[j]) % MOD;
                }
            }
            totalSum = (totalSum + product) % MOD;
        }
    }
    return (int)totalSum;
}