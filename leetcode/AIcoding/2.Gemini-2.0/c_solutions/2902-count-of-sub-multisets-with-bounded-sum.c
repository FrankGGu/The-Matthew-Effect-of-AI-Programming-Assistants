#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int countSubMultisets(int* nums, int numsSize, int l, int r) {
    int count[100001] = {0};
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }

    int max_val = 0;
    for (int i = 0; i <= 100000; i++) {
        if (count[i] > 0) {
            max_val = i;
        }
    }

    int dp[r + 1];
    for (int i = 0; i <= r; i++) {
        dp[i] = 0;
    }
    dp[0] = 1;

    for (int i = 1; i <= max_val; i++) {
        if (count[i] == 0) continue;
        for (int j = 1; j <= count[i]; j++) {
            for (int k = r; k >= i; k--) {
                dp[k] = (dp[k] + dp[k - i]) % MOD;
            }
        }
    }

    long long ans = 0;
    for (int i = l; i <= r; i++) {
        ans = (ans + dp[i]) % MOD;
    }

    long long zero_count = count[0];
    long long zero_power = 1;
    if (zero_count > 0) {
        zero_power = (zero_power * (zero_count + 1)) % MOD;
    }

    return (ans * zero_power) % MOD;
}