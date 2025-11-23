#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <limits.h> // For LLONG_MAX

static long long power_of_10[20];
static int powers_precomputed = 0;

void precompute_powers_once() {
    if (!powers_precomputed) {
        power_of_10[0] = 1;
        for (int i = 1; i < 20; ++i) {
            power_of_10[i] = power_of_10[i - 1] * 10;
        }
        powers_precomputed = 1;
    }
}

long long countPowerful(long long N_val, int limit, char* s_str) {
    if (N_val < 0) {
        return 0;
    }

    int k = strlen(s_str);
    long long s_val = atoll(s_str);
    long long p10k = power_of_10[k];

    long long ans = 0;

    // Determine if 's' has a leading zero and is multi-digit.
    // Example: s="05", k=2. s_val=5. to_string(5) is "5". It does not end in "05".
    // So, if s_str has a leading zero and k > 1, then x must have length > k.
    // Example: s="0", k=1. s_val=0. to_string(0) is "0". It ends in "0".
    // So, if k=1, leading '0' is fine.
    int s_has_leading_zero_multi_digit = (k > 1 && s_str[0] == '0');

    // Iterate over possible lengths L of the powerful integer x
    // L must be at least k.
    // L must be at most limit.
    for (int L = k; L <= limit; ++L) {
        int prefix_len = L - k;

        // If s_str starts with '0' (and k > 1) AND prefix_len == 0:
        // This means L == k. x would be s_val.
        // But if s_has_leading_zero_multi_digit is true, s_val has fewer than k digits
        // (e.g., "05" -> 5). So to_string(s_val) will not end with s_str.
        // Thus, no powerful integer of length k in this specific case.
        if (s_has_leading_zero_multi_digit && prefix_len == 0) {
            continue;
        }

        // Calculate the maximum allowed prefix_val such that x <= N_val
        // x = prefix_val * p10k + s_val
        // prefix_val * p10k <= N_val - s_val
        // prefix_val <= (N_val - s_val) / p10k
        long long max_allowed_prefix_val = (N_val >= s_val) ? (N_val - s_val) / p10k : -1;

        long long current_count_for_len_L = 0;

        if (prefix_len == 0) { // L == k. x must be s_val.
            // This case is reached only if s_str does not have a leading zero (or k=1).
            // So s_val is a k-digit number (or "0" if k=1).
            // If s_val <= N_val, then s_val is a powerful integer.
            if (s_val <= N_val) {
                // Problem states "positive integer". So 0 is not powerful.
                if (s_val > 0) { 
                    current_count_for_len_L = 1;
                }
            }
        } else { // prefix_len > 0. prefix_val must be a positive number with prefix_len digits.
            long long min_prefix_val_for_len = power_of_10[prefix_len - 1];
            long long max_prefix_val_for_len = power_of_10[prefix_len] - 1;

            // The actual range for prefix_val is the intersection of:
            // 1. [min_prefix_val_for_len, max_prefix_val_for_len] (to have prefix_len digits)
            // 2. [0, max_allowed_prefix_val] (to keep x <= N_val)
            long long actual_min_prefix_val = min_prefix_val_for_len;
            long long actual_max_prefix_val = max_allowed_prefix_val;
            if (actual_max_prefix_val > max_prefix_val_for_len) {
                actual_max_prefix_val = max_prefix_val_for_len;
            }

            if (actual_max_prefix_val >= actual_min_prefix_val) {
                current_count_for_len_L = actual_max_prefix_val - actual_min_prefix_val + 1;
            }
        }
        ans += current_count_for_len_L;
    }
    return ans;
}

long long numberOfPowerfulInt(long long low, long long high, int limit, char* s) {
    precompute_powers_once();

    // Count powerful integers up to high, then subtract powerful integers up to low-1.
    return countPowerful(high, limit, s) - countPowerful(low - 1, limit, s);
}