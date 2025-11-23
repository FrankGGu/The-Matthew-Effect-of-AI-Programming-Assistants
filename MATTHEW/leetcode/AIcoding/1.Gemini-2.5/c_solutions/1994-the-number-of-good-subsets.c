#include <stdlib.h>
#include <string.h>

static int primes_arr[] = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29};
static int primes_count = sizeof(primes_arr) / sizeof(primes_arr[0]);

static int masks[31];
static int counts[31];

static const int MOD = 1000000007;

static int precomputed = 0;

void precompute_data() {
    if (precomputed) return;

    for (int i = 0; i <= 30; ++i) {
        masks[i] = 0;
    }

    for (int i = 2; i <= 30; ++i) {
        int temp_mask = 0;
        int temp_num = i;
        int is_square_free = 1;

        for (int j = 0; j < primes_count; ++j) {
            if (temp_num % primes_arr[j] == 0) {
                temp_mask |= (1 << j);
                temp_num /= primes_arr[j];
                if (temp_num % primes_arr[j] == 0) {
                    is_square_free = 0;
                    break;
                }
            }
        }
        if (is_square_free) {
            masks[i] = temp_mask;
        } else {
            masks[i] = -1;
        }
    }
    precomputed = 1;
}

int numberOfGoodSubsets(int* nums, int numsSize) {
    precompute_data();

    for (int i = 0; i <= 30; ++i) {
        counts[i] = 0;
    }
    for (int i = 0; i < numsSize; ++i) {
        counts[nums[i]]++;
    }

    int dp[1 << 10];
    memset(dp, 0, sizeof(dp));
    dp[0] = 1;

    for (int i = 2; i <= 30; ++i) {
        if (masks[i] == -1 || counts[i] == 0) {
            continue;
        }

        int current_num_mask = masks[i];
        for (int j = (1 << primes_count) - 1; j >= 0; --j) {
            if (dp[j] > 0) {
                if ((j & current_num_mask) == 0) {
                    dp[j | current_num_mask] = (dp[j | current_num_mask] + (long long)dp[j] * counts[i]) % MOD;
                }
            }
        }
    }

    long long total_ways_gt_1 = 0;
    for (int mask = 0; mask < (1 << primes_count); ++mask) {
        total_ways_gt_1 = (total_ways_gt_1 + dp[mask]) % MOD;
    }

    if (counts[1] > 0) {
        long long power_of_2_for_ones = 1;
        for (int k = 0; k < counts[1]; ++k) {
            power_of_2_for_ones = (power_of_2_for_ones * 2) % MOD;
        }
        total_ways_gt_1 = (total_ways_gt_1 * power_of_2_for_ones) % MOD;
    }

    return (int)((total_ways_gt_1 - 1 + MOD) % MOD);
}