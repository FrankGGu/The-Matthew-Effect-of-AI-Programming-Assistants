#include <stddef.h>

long long calculate_gcd(long long a, long long b) {
    while (b) {
        long long temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

long long calculate_lcm(long long a, long long b, long long limit) {
    if (a == 1) return b;
    if (b == 1) return a;

    long long common_divisor = calculate_gcd(a, b);

    long long val_a_div_gcd = a / common_divisor;
    if (val_a_div_gcd > limit / b) { 
        return limit + 1;
    }
    return val_a_div_gcd * b;
}

long long count_valid_amounts(int* coins, int coinsSize, long long target_x) {
    long long total_count = 0;

    for (int i = 1; i < (1 << coinsSize); ++i) {
        long long current_lcm = 1;
        int set_bits = 0;

        for (int j = 0; j < coinsSize; ++j) {
            if ((i >> j) & 1) {
                set_bits++;

                if (current_lcm > target_x) {
                    break; 
                }

                current_lcm = calculate_lcm(current_lcm, coins[j], target_x);
            }
        }

        if (current_lcm <= target_x) {
            if (set_bits % 2 == 1) {
                total_count += (target_x / current_lcm);
            } else {
                total_count -= (target_x / current_lcm);
            }
        }
    }
    return total_count;
}

long long kthSmallestAmount(int* coins, int coinsSize, int k) {
    long long low = 1;
    long long high = 2000000000000LL;
    long long ans = high;

    while (low <= high) {
        long long mid = low + (high - low) / 2;

        if (count_valid_amounts(coins, coinsSize, mid) >= k) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
}