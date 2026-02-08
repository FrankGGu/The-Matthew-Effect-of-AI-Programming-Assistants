#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    static const int MAX_VAL = 1000; // Max value of nums[i]

    // Static members for sieve
    static std::vector<bool> is_prime;
    static bool sieve_initialized;

    // Sieve of Eratosthenes to precompute primes up to MAX_VAL
    static void sieve() {
        if (sieve_initialized) return; // Only run once

        is_prime.assign(MAX_VAL + 1, true);
        is_prime[0] = is_prime[1] = false; // 0 and 1 are not prime

        for (int p = 2; p * p <= MAX_VAL; ++p) {
            if (is_prime[p]) {
                for (int i = p * p; i <= MAX_VAL; i += p)
                    is_prime[i] = false;
            }
        }

        sieve_initialized = true;
    }

    bool primeSubOperation(std::vector<int>& nums) {
        sieve(); // Ensure primes are precomputed

        int n = nums.size();

        // Process nums[0]
        // We want to make nums[0] as small as possible while still positive.
        // We iterate `new_val` from 1 up to `nums[0] - 1`.
        // The first `new_val` for which `nums[0] - new_val` is prime is the smallest possible value for nums[0].
        int target_val_0 = nums[0]; // Default: no subtraction
        for (int new_val = 1; new_val < nums[0]; ++new_val) {
            if (is_prime[nums[0] - new_val]) {
                target_val_0 = new_val;
                break; // Found the smallest possible new_val by subtracting a prime
            }
        }
        nums[0] = target_val_0;

        // Process nums[i] for i > 0
        for (int i = 1; i < n; ++i) {
            int prev_val = nums[i-1];

            // We need nums[i] to be strictly greater than prev_val.
            // We want to find the smallest `new_nums_i` such that:
            // 1. `new_nums_i > prev_val`
            // 2. `new_nums_i = nums[i] - p` for some prime `p` (which means `nums[i] - new_nums_i` is prime)
            // 3. `new_nums_i` is as small as possible.

            int current_original_val = nums[i]; // Store original value for comparison
            int new_val_after_subtraction = -1; // Sentinel for if a suitable new_val is found by subtraction

            // Iterate possible `k` (which represents `new_nums_i`) from `(prev_val + 1)` up to `(current_original_val - 1)`.
            // We want the smallest such `k`.
            for (int k = prev_val + 1; k < current_original_val; ++k) {
                // Check if `(current_original_val - k)` is a prime number
                if (is_prime[current_original_val - k]) {
                    new_val_after_subtraction = k;
                    break; // Found the smallest possible `k` by subtraction
                }
            }

            if (new_val_after_subtraction != -1) {
                // We found a way to make nums[i] smaller and satisfy the condition
                nums[i] = new_val_after_subtraction;
            } else {
                // No prime subtraction can make nums[i] smaller while satisfying nums[i] > prev_val.
                // We must rely on the original nums[i].
                if (current_original_val <= prev_val) {
                    // Original nums[i] does not satisfy the condition, and we couldn't subtract a prime.
                    return false;
                }
                // If current_original_val > prev_val, we just keep current_original_val as is.
                // nums[i] already holds current_original_val, so no assignment needed.
            }
        }

        return true;
    }
};

std::vector<bool> Solution::is_prime;
bool Solution::sieve_initialized = false;