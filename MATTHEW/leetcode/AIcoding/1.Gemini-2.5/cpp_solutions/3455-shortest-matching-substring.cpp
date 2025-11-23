#include <string>
#include <vector>
#include <limits> // For std::numeric_limits

class Solution {
public:
    std::string minWindow(std::string s, std::string t) {
        if (t.empty()) {
            return "";
        }

        std::vector<int> target_char_counts(128, 0);
        for (char c : t) {
            target_char_counts[c]++;
        }

        int left = 0;
        int min_len = std::numeric_limits<int>::max();
        int min_start_idx = 0;
        int matched_count = 0;

        std::vector<int> window_char_counts(128, 0);

        for (int right = 0; right < s.length(); ++right) {
            char current_char = s[right];
            window_char_counts[current_char]++;

            if (target_char_counts[current_char] > 0 && window_char_counts[current_char] <= target_char_counts[current_char]) {
                matched_count++;
            }

            while (matched_count == t.length()) {
                int current_window_len = right - left + 1;
                if (current_window_len < min_len) {
                    min_len = current_window_len;
                    min_start_idx = left;
                }

                char char_from_left = s[left];
                window_char_counts[char_from_left]--;

                if (target_char_counts[char_from_left] > 0 && window_char_counts[char_from_left] < target_char_counts[char_from_left]) {
                    matched_count--;
                }
                left++;
            }
        }

        if (min_len == std::numeric_limits<int>::max()) {
            return "";
        } else {
            return s.substr(min_start_idx, min_len);
        }
    }
};