#include <vector>

class Solution {
public:
    std::vector<long long> sortedGcdPairQueries(std::vector<int>& nums, std::vector<int>& queries) {
        const int MAX_VAL = 100001;

        std::vector<int> freq(MAX_VAL, 0);
        for (int x : nums) {
            freq[x]++;
        }

        std::vector<long long> num_multiples(MAX_VAL, 0);
        for (int g = 1; g < MAX_VAL; ++g) {
            for (int j = g; j < MAX_VAL; j += g) {
                num_multiples[g] += freq[j];
            }
        }

        std::vector<long long> C(MAX_VAL, 0);
        for (int g = 1; g < MAX_VAL; ++g) {
            C[g] = num_multiples[g] * (num_multiples[g] - 1) / 2;
        }

        std::vector<long long> count_exact_gcd(MAX_VAL, 0);
        for (int g = MAX_VAL - 1; g >= 1; --g) {
            count_exact_gcd[g] = C[g];
            for (int j = 2 * g; j < MAX_VAL; j += g) {
                count_exact_gcd[g] -= count_exact_gcd[j];
            }
        }

        std::vector<long long> ans_suffix_sum(MAX_VAL + 1, 0);
        for (int k = MAX_VAL - 1; k >= 1; --k) {
            ans_suffix_sum[k] = ans_suffix_sum[k + 1] + count_exact_gcd[k];
        }

        std::vector<long long> result;
        result.reserve(queries.size());
        for (int q : queries) {
            result.push_back(ans_suffix_sum[q]);
        }

        return result;
    }
};