#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int numberOfGoodSubsets(int* nums, int numsSize) {
    int primes[] = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29};
    int mask[] = {1, 2, 3, 5, 7, 11, 13, 17, 19, 23, 29};
    int count[31] = {0};
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }
    long long dp[1 << 10] = {0};
    dp[0] = 1;
    for (int i = 2; i <= 30; i++) {
        if (count[i] == 0) continue;
        int subset = 0;
        int num = i;
        bool valid = true;
        for (int j = 0; j < 10; j++) {
            if (num % primes[j] == 0) {
                if (num % (primes[j] * primes[j]) == 0) {
                    valid = false;
                    break;
                }
                subset |= (1 << j);
            }
        }
        if (!valid) continue;
        for (int j = (1 << 10) - 1; j >= 0; j--) {
            if ((j & subset) == subset) {
                dp[j] = (dp[j] + dp[j ^ subset] * count[i]) % MOD;
            }
        }
    }
    long long ans = 0;
    for (int i = 1; i < (1 << 10); i++) {
        ans = (ans + dp[i]) % MOD;
    }
    long long powerOfTwo = 1;
    for (int i = 0; i < count[1]; i++) {
        powerOfTwo = (powerOfTwo * 2) % MOD;
    }
    ans = (ans * powerOfTwo) % MOD;
    return (int)ans;
}