#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int longestSpecialSubstring(std::string s) {
        int n = s.length();
        if (n < 3) {
            return -1;
        }

        std::vector<std::vector<int>> char_block_lengths(26);

        int i = 0;
        while (i < n) {
            char current_char = s[i];
            int j = i;
            while (j < n && s[j] == current_char) {
                j++;
            }
            char_block_lengths[current_char - 'a'].push_back(j - i);
            i = j;
        }

        int overall_max_L = -1;

        for (int char_idx = 0; char_idx < 26; ++char_idx) {
            const std::vector<int>& lengths = char_block_lengths[char_idx];
            if (lengths.empty()) {
                continue;
            }

            int max_block_len = 0;
            for (int len : lengths) {
                max_block_len = std::max(max_block_len, len);
            }

            int low = 1, high = max_block_len;
            int ans_for_ch = -1;

            while (low <= high) {
                int mid = low + (high - low) / 2;

                long long current_occurrences = 0;
                for (int b_len : lengths) {
                    if (b_len >= mid) {
                        current_occurrences += (b_len - mid + 1);
                    }
                }

                if (current_occurrences >= 3) {
                    ans_for_ch = mid;
                    low = mid + 1; 
                } else {
                    high = mid - 1;
                }
            }
            overall_max_L = std::max(overall_max_L, ans_for_ch);
        }

        return overall_max_L;
    }
};