#include <string>
#include <algorithm>
#include <cmath>
#include <limits>

int check(unsigned long long k, int m, unsigned long long n) {
    unsigned long long current_sum = 1;
    unsigned long long current_power_of_k = 1;

    for (int i = 1; i <= m; ++i) {
        // Check for potential overflow before multiplying current_power_of_k by k.
        // If current_power_of_k > n / k, then current_power_of_k * k would exceed n.
        // This also implicitly handles cases where current_power_of_k * k would overflow ULLONG_MAX,
        // as ULLONG_MAX / k would be smaller than n / k for k >= 2.
        if (current_power_of_k > n / k) {
            return 1; // sum will be > n
        }
        current_power_of_k *= k;

        // Check for potential overflow before adding current_power_of_k to current_sum.
        // If current_sum > n - current_power_of_k, then current_sum + current_power_of_k would exceed n.
        // This also implicitly handles cases where current_sum + current_power_of_k would overflow ULLONG_MAX.
        if (current_sum > n - current_power_of_k) {
            return 1; // sum will be > n
        }
        current_sum += current_power_of_k;
    }

    if (current_sum == n) {
        return 0;
    } else if (current_sum < n) {
        return -1;
    } else { // current_sum > n
        return 1;
    }
}

class Solution {
public:
    std::string smallestGoodBase(std::string n_str) {
        unsigned long long n = std::stoull(n_str);

        // Iterate on the length of the '1' sequence, which is m+1.
        // m is the highest power of k.
        // n = k^m + k^(m-1) + ... + k + 1
        // Maximum possible m: If k=2, 2^(m+1) - 1 <= n => m+1 <= log2(n+1).
        // For n = 10^18, log2(10^18+1) is approximately 59.79. So m can be up to 59.
        // We iterate m from max_m down to 2.
        // If m=1, n = k+1, so k = n-1. This is always a good base, and it's usually the largest.
        // We are looking for the smallest k, so we prioritize larger m values.
        for (int m = 60; m >= 2; --m) {
            // For a given m, k^m < n, so k < n^(1/m).
            // We can binary search for k in the range [2, (unsigned long long)pow(n, 1.0/m) + 2].
            // The +2 is a safety margin for floating point precision issues.
            // The upper bound for k can be roughly n^(1/m).
            // For m=2, k_upper_bound is sqrt(n) ~ 10^9.
            // For m=59, k_upper_bound is n^(1/59) ~ 2.
            unsigned long long low = 2;
            unsigned long long high = static_cast<unsigned long long>(std::pow(n, 1.0 / m)) + 2;

            // No need to cap high at n-1 because n^(1/m) is always much smaller than n for m>=2.

            while (low <= high) {
                unsigned long long mid = low + (high - low) / 2;

                // k must be at least 2. If mid somehow becomes 0 or 1, adjust.
                if (mid < 2) { 
                    low = 2; 
                    continue; 
                }

                int cmp_result = check(mid, m, n);

                if (cmp_result == 0) { // Found n for this k and m
                    return std::to_string(mid);
                } else if (cmp_result == -1) { // sum < n, k is too small
                    low = mid + 1;
                } else { // sum > n, k is too large
                    high = mid - 1;
                }
            }
        }

        // If no base k is found for m >= 2, then m=1 is the only option.
        // n = k^1 + k^0 = k + 1 => k = n - 1.
        return std::to_string(n - 1);
    }
};