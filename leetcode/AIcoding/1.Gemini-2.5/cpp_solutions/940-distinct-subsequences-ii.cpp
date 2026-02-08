#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    int distinctSubseqII(std::string s) {
        long long MOD = 1e9 + 7;

        long long total_distinct_subsequences = 0;

        std::vector<long long> last(26, 0);

        for (char c : s) {
            int char_idx = c - 'a';

            long long current_char_contribution = (total_distinct_subsequences + 1) % MOD;

            long long actual_new_subsequences_ending_with_c = (current_char_contribution - last[char_idx] + MOD) % MOD;

            total_distinct_subsequences = (total_distinct_subsequences + actual_new_subsequences_ending_with_c) % MOD;

            last[char_idx] = current_char_contribution;
        }

        return static_cast<int>(total_distinct_subsequences);
    }
};