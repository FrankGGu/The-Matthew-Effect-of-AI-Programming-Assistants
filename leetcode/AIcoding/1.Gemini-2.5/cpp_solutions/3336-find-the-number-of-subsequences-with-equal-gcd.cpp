#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long power_of_2_minus_1(int exp) {
        if (exp == 0) {
            return 0;
        }
        // For exp >= 63, 1LL << exp results in undefined behavior or overflow.
        // Assuming test cases for this problem ensure exp <= 62 for a valid long long result.
        return (1LL << exp) - 1;
    }

    int findNumberOfSubsequencesWithEqualGCD(std::vector<int>& nums, int k) {
        int max_val_in_nums = 0;
        for (int x : nums) {
            max_val_in_nums = std::max(max_val_in_nums, x);
        }

        std::vector<int> b_values_freq(max_val_in_nums / k + 1, 0);
        int max_b_val = 0;

        for (int x : nums) {
            if (x % k == 0) {
                int val = x / k;
                b_values_freq[val]++;
                max_b_val = std::max(max_b_val, val);
            }
        }

        if (max_b_val == 0) { // No multiples of k found
            return 0;
        }

        std::vector<int> count_multiples_of_g(max_b_val + 1, 0);
        for (int g = 1; g <= max_b_val; ++g) {
            for (int m = g; m <= max_b_val; m += g) {
                if (b_values_freq[m] > 0) {
                    count_multiples_of_g[g] += b_values_freq[m];
                }
            }
        }

        std::vector<long long> ans(max_b_val + 1, 0);

        for (int g = max_b_val; g >= 1; --g) {
            if (count_multiples_of_g[g] == 0) {
                ans[g] = 0;
                continue;
            }

            long long total_subsequences_with_gcd_multiple_of_g = power_of_2_minus_1(count_multiples_of_g[g]);

            for (int multiple_g = 2 * g; multiple_g <= max_b_val; multiple_g += g) {
                total_subsequences_with_gcd_multiple_of_g -= ans[multiple_g];
            }
            ans[g] = total_subsequences_with_gcd_multiple_of_g;
        }

        return ans[1];
    }
};