#include <string>
#include <algorithm> // For std::max

class Solution {
public:
    int longestSemiRepetitiveSubstring(std::string s) {
        int n = s.length();

        int left = 0;
        int max_len = 0;
        int count_adjacent_pairs = 0;

        for (int right = 0; right < n; ++right) {
            if (right > 0 && s[right] == s[right - 1]) {
                count_adjacent_pairs++;
            }

            while (count_adjacent_pairs > 1) {
                if (s[left] == s[left + 1]) {
                    count_adjacent_pairs--;
                }
                left++;
            }
            max_len = std::max(max_len, right - left + 1);
        }

        return max_len;
    }
};