#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int countPartitions(int n, int* nums, int numsSize) {
    long long sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum = (sum + nums[i]) % MOD;
    }

    if (sum % 2 != 0) {
        return 0;
    }

    long long target = sum / 2;
    long long dp[target + 1];
    for (int i = 0; i <= target; i++) {
        dp[i] = 0;
    }
    dp[0] = 1;

    for (int i = 0; i < numsSize; i++) {
        for (int j = target; j >= nums[i]; j--) {
            dp[j] = (dp[j] + dp[j - nums[i]]) % MOD;
        }
    }

    long long total_subsets = 1;
    for(int i = 0; i < numsSize; i++){
        total_subsets = (total_subsets * 2) % MOD;
    }

    long long ans = (2 * dp[target]) % MOD;

    if(ans > total_subsets){
        ans = (ans - total_subsets + MOD) % MOD;
    } else {
        ans = (total_subsets - ans + MOD) % MOD;
    }

    long long result = (dp[target] * 2) % MOD;
    if(result > total_subsets){
        result = (result - total_subsets + MOD) % MOD;
    } else {
        result = (total_subsets - result + MOD) % MOD;
    }

    return (int)result;
}