#include <string.h>
#include <stdlib.h>
#include <stdio.h>

char* smallestGoodBase(char* n_str) {
    unsigned long long n_val = strtoull(n_str, NULL, 10);

    // Iterate m (number of ones) from max possible down to 2.
    // Max m occurs when k=2. n = 2^m - 1. So 2^m = n+1. m = log2(n+1).
    // For n = 10^18, log2(10^18+1) is approximately 59.79. So m can be up to 60.
    for (int m = 60; m >= 2; --m) {
        unsigned long long low_bs = 2;
        unsigned long long high_bs;

        if (m == 2) {
            // For m=2, n = k+1, so k = n-1. This is the largest possible base.
            // The binary search range must cover n_val-1.
            high_bs = n_val - 1;
        } else {
            // For m >= 3, k^(m-1) < n_val.
            // Max n_val is 10^18.
            // If m=3, k^2 < 10^18 => k < 10^9.
            // If m=4, k^3 < 10^18 => k < 10^6.
            // So, k will not exceed 10^9.
            // A safe upper bound for k for m >= 3 is 10^9 + a small buffer.
            high_bs = 1000000000ULL + 7;
            // Cap high_bs to n_val - 1, as k cannot be larger than n_val - 1.
            if (high_bs > n_val - 1) {
                high_bs = n_val - 1;
            }
        }

        // Ensure high_bs is at least low_bs
        if (high_bs < low_bs) high_bs = low_bs;

        unsigned long long ans_k = 0;

        while (low_bs <= high_bs) {
            unsigned long long mid_k = low_bs + (high_bs - low_bs) / 2;
            if (mid_k < 2) { // Base k must be >= 2
                low_bs = 2;
                continue;
            }

            unsigned long long current_sum = 0;
            unsigned long long term = 1;
            int overflow = 0;

            for (int p = 0; p < m; ++p) {
                current_sum += term;
                if (current_sum > n_val) { // Sum exceeded n_val
                    overflow = 1;
                    break;
                }
                if (p < m - 1) { // Prepare for next term, check for overflow before multiplication
                    // Check if term * mid_k would overflow unsigned long long or exceed n_val
                    // term * mid_k > n_val is equivalent to term > n_val / mid_k
                    if (mid_k == 0 || term > n_val / mid_k) { 
                        overflow = 1;
                        break;
                    }
                    term *= mid_k;
                }
            }

            if (overflow || current_sum > n_val) {
                high_bs = mid_k - 1;
            } else if (current_sum < n_val) {
                low_bs = mid_k + 1;
            } else { // current_sum == n_val
                ans_k = mid_k;
                // Found a k for this m. Since we iterate m downwards,
                // this k is the smallest good base.
                char* result = (char*)malloc(25 * sizeof(char)); // Max 20 digits for 10^18, plus null terminator
                sprintf(result, "%llu", ans_k);
                return result;
            }
        }
    }

    // The problem guarantees a solution exists. The loop will always find one.
    // The m=2 case (k=n_val-1) will always be found if no solution for m > 2 exists.
    return NULL; 
}