#include <stdlib.h>

static int primes[] = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29};
static int num_primes = 10;
static int MOD = 1e9 + 7;

static int prime_masks[31];
static int is_sf[31];
static int precomputed = 0;

void precompute_data() {
    if (precomputed) {
        return;
    }

    for (int i = 1; i <= 30; ++i) {
        int temp = i;
        int mask = 0;
        int sf = 1;

        for (int j = 0; j < num_primes; ++j) {
            int p = primes[j];
            if (temp % p == 0) {
                mask |= (1 << j);
                temp /= p;
                if (temp % p == 0) {
                    sf = 0;
                    break;
                }
            }
        }

        prime_masks[i] = mask;
        is_sf[i] = sf;
    }
    precomputed = 1;
}

int countSquareFreeSubsets(int* nums, int numsSize) {
    precompute_data();

    long long dp[1 << 10];
    for (int i = 0; i < (1 << 10); ++i) {
        dp[i] = 0;
    }
    dp[0] = 1;

    int count_ones = 0;

    for (int i = 0; i < numsSize; ++i) {
        int num = nums[i];
        if (num == 1) {
            count_ones++;
            continue;
        }

        if (!is_sf[num]) {
            continue;
        }

        int current_mask = prime_masks[num];

        for (int mask = (1 << 10) - 1; mask >= 0; --mask) {
            if (dp[mask] > 0) {
                if ((mask & current_mask) == 0) {
                    dp[mask | current_mask] = (dp[mask | current_mask] + dp[mask]) % MOD;
                }
            }
        }
    }

    long long total_subsets_from_non_ones = 0;
    for (int mask = 0; mask < (1 << 10); ++mask) {
        total_subsets_from_non_ones = (total_subsets_from_non_ones + dp[mask]) % MOD;
    }

    long long power_of_2_ones = 1;
    for (int i = 0; i < count_ones; ++i) {
        power_of_2_ones = (power_of_2_ones * 2) % MOD;
    }

    long long final_result = (total_subsets_from_non_ones * power_of_2_ones) % MOD;
    final_result = (final_result - 1 + MOD) % MOD;

    return (int)final_result;
}