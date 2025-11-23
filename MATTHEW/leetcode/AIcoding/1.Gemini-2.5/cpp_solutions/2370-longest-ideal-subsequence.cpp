#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int longestIdealString(std::string s, int k) {
        std::vector<int> dp(26, 0);
        int result = 0;

        for (char c : s) {
            int curr_char_idx = c - 'a';
            int max_len_before = 0;

            int start = std::max(0, curr_char_idx - k);
            int end = std::min(25, curr_char_idx + k);

            for (int prev_char_idx = start; prev_char_idx <= end; ++prev_char_idx) {
                max_len_before = std::max(max_len_before, dp[prev_char_idx]);
            }

            dp[curr_char_idx] = max_len_before + 1;
            result = std::max(result, dp[curr_char_idx]);
        }

        return result;
    }
};