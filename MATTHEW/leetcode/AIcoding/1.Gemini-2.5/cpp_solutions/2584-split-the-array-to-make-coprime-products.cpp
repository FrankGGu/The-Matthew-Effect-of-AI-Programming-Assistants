#include <vector>
#include <numeric> // For std::iota

class Solution {
public:
    static const int MAX_VAL = 1000000;
    static std::vector<int> spf; // Smallest Prime Factor
    static bool sieve_initialized;

    void initialize_sieve() {
        if (sieve_initialized) {
            return;
        }
        spf.resize(MAX_VAL + 1);
        std::iota(spf.begin(), spf.end(), 0); // Initialize spf[i] = i

        for (int i = 2; i * i <= MAX_VAL; ++i) {
            if (spf[i] == i) { // i is prime
                for (int j = i * i; j <= MAX_VAL; j += i) {
                    if (spf[j] == j) { // Only update if not already found a smaller prime factor
                        spf[j] = i;
                    }
                }
            }
        }
        sieve_initialized = true;
    }

    int splitArray(std::vector<int>& nums) {
        initialize_sieve();

        int n = nums.size();
        // Constraints state n >= 2, so this check is mostly for robustness.
        if (n < 2) { 
            return -1;
        }

        std::vector<int> left_prime_counts(MAX_VAL + 1, 0);
        std::vector<int> right_prime_counts(MAX_VAL + 1, 0);
        int shared_prime_count = 0;

        // Initialize right_prime_counts for the product of all elements in nums
        for (int x : nums) {
            int temp_x = x;
            while (temp_x > 1) {
                int p = spf[temp_x];
                right_prime_counts[p]++;
                while (temp_x > 1 && temp_x % p == 0) {
                    temp_x /= p;
                }
            }
        }

        // Iterate through possible split points i
        // The split is nums[0...i] and nums[i+1...n-1]
        for (int i = 0; i < n - 1; ++i) {
            int current_num = nums[i];
            int temp_num = current_num;

            // Move prime factors of current_num from the right subarray to the left subarray
            while (temp_num > 1) {
                int p = spf[temp_num];

                // Before decrementing right_prime_counts[p]:
                // If this prime 'p' was present in both left and right subarrays (i.e., shared)
                // AND its count in the right subarray becomes 0 after this element moves,
                // then 'p' is no longer shared.
                if (left_prime_counts[p] > 0 && right_prime_counts[p] == 1) {
                    shared_prime_count--;
                }
                right_prime_counts[p]--;

                // After decrementing right_prime_counts[p] and before incrementing left_prime_counts[p]:
                // If this prime 'p' was not present in the left subarray
                // AND it is still present in the right subarray (meaning right_prime_counts[p] > 0 after decrement),
                // then 'p' becomes shared.
                if (left_prime_counts[p] == 0 && right_prime_counts[p] > 0) {
                    shared_prime_count++;
                }
                left_prime_counts[p]++;

                // Remove all occurrences of p from temp_num to find next distinct prime factor
                while (temp_num > 1 && temp_num % p == 0) {
                    temp_num /= p;
                }
            }

            // After processing nums[i], if no prime factors are shared between the two subarrays,
            // then this is a valid split point. Return the smallest such index i.
            if (shared_prime_count == 0) {
                return i;
            }
        }

        // If no such split point is found, return -1
        return -1;
    }
};

std::vector<int> Solution::spf;
bool Solution::sieve_initialized = false;