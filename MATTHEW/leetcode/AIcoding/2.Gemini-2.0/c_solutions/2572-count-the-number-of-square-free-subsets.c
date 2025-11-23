#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int squareFreeSubsets(int* nums, int numsSize) {
    int primes[] = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29};
    int mask_map[31] = {0};
    mask_map[1] = 0;
    for (int i = 2; i <= 30; i++) {
        int mask = 0;
        int num = i;
        for (int j = 0; j < 10; j++) {
            if (num % primes[j] == 0) {
                if (num % (primes[j] * primes[j]) == 0) {
                    mask = -1;
                    break;
                }
                mask |= (1 << j);
                num /= primes[j];
            }
        }
        mask_map[i] = mask;
    }

    long long dp[1 << 10];
    for (int i = 0; i < (1 << 10); i++) {
        dp[i] = 0;
    }
    dp[0] = 1;

    int count_one = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            count_one++;
            continue;
        }
        int mask = mask_map[nums[i]];
        if (mask == -1) continue;

        for (int j = (1 << 10) - 1; j >= 0; j--) {
            if ((j & mask) == 0) {
                dp[j | mask] = (dp[j | mask] + dp[j]) % MOD;
            }
        }
    }

    long long ans = 0;
    for (int i = 1; i < (1 << 10); i++) {
        ans = (ans + dp[i]) % MOD;
    }

    long long power_of_two = 1;
    for (int i = 0; i < count_one; i++) {
        power_of_two = (power_of_two * 2) % MOD;
    }

    ans = (ans * power_of_two) % MOD;
    return (int)ans;
}