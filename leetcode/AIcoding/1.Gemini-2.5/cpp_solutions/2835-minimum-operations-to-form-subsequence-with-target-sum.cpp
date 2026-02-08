#include <vector>
#include <numeric> // For std::accumulate, though not directly used here
#include <cmath>   // For log2, not strictly needed with __builtin_ctz
#include <map>     // Can be used for counts, but array is better for fixed range

class Solution {
public:
    long long minOperations(std::vector<int>& nums, int target) {
        // counts[i] stores the frequency of 2^i in nums
        // Max target is 10^9, which is less than 2^30.
        // So powers up to 2^30 (index 30) might be relevant.
        // A size of 31 covers 2^0 to 2^30.
        long long counts[31] = {0}; 

        for (int x : nums) {
            // __builtin_ctz(x) returns the number of trailing zeros in x's binary representation.
            // For a power of 2, 2^p, it returns p.
            counts[__builtin_ctz(x)]++;
        }

        long long operations = 0;
        // available_from_smaller stores the sum of values of powers of 2 (2^j for j < i)
        // that we currently possess and haven't used to satisfy target bits.
        // This sum can be used to form higher powers of 2.
        long long available_from_smaller = 0; 

        for (int i = 0; i <= 30; ++i) {
            // Add the current 2^i's from initial nums to our pool of available smaller powers.
            // These can be combined with other smaller powers to form higher powers.
            available_from_smaller += counts[i] * (1LL << i);

            // Check if the i-th bit of target is set.
            // If it is, we need a 2^i.
            if ((target >> i) & 1) {
                // If we have enough value from smaller powers (including current 2^i's)
                // to form a 2^i, use it.
                if (available_from_smaller >= (1LL << i)) {
                    available_from_smaller -= (1LL << i);
                } else {
                    // We don't have enough 2^i's from current or smaller powers.
                    // We need to find a larger power of 2 (2^k, where k > i)
                    // and break it down.
                    int k = i + 1;
                    while (k <= 30 && counts[k] == 0) {
                        k++;
                    }

                    // If no larger power of 2 is available, it's impossible to form target.
                    if (k > 30) {
                        return -1;
                    }

                    // Found a 2^k. Use one.
                    counts[k]--;
                    // Breaking 2^k down to 2^i costs k - i operations.
                    operations += (k - i);
                    // Add the value of the broken-down 2^k to our pool.
                    // This 2^k will provide the needed 2^i, and the remaining value
                    // (2^k - 2^i) will be added to available_from_smaller.
                    available_from_smaller += (1LL << k) - (1LL << i);
                }
            }
        }

        return operations;
    }
};