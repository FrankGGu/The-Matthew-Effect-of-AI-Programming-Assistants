#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    int numWays(std::string s) {
        long long n = s.length();
        long long MOD = 1e9 + 7;

        std::vector<int> one_indices;
        for (int i = 0; i < n; ++i) {
            if (s[i] == '1') {
                one_indices.push_back(i);
            }
        }

        long long total_ones = one_indices.size();

        if (total_ones == 0) {
            if (n < 3) {
                return 0;
            }
            long long ways = ((n - 1) * (n - 2) / 2) % MOD;
            return ways;
        }

        if (total_ones % 3 != 0) {
            return 0;
        }

        long long ones_per_part = total_ones / 3;

        long long ways1 = one_indices[ones_per_part] - one_indices[ones_per_part - 1];
        long long ways2 = one_indices[2 * ones_per_part] - one_indices[2 * ones_per_part - 1];

        long long result = (ways1 * ways2) % MOD;

        return result;
    }
};