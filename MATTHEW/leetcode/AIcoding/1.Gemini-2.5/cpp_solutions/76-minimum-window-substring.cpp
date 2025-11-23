#include <string>
#include <vector>
#include <limits>

class Solution {
public:
    std::string minWindow(std::string s, std::string t) {
        if (t.empty()) {
            return "";
        }

        std::vector<int> t_freq(128, 0);
        for (char c : t) {
            t_freq[c]++;
        }

        int left = 0;
        int min_len = std::numeric_limits<int>::max();
        int start_idx = 0;
        int formed_count = 0;

        std::vector<int> window_freq(128, 0);

        for (int right = 0; right < s.length(); ++right) {
            char char_r = s[right];

            if (t_freq[char_r] > 0) {
                window_freq[char_r]++;
                if (window_freq[char_r] <= t_freq[char_r]) {
                    formed_count++;
                }
            }

            while (formed_count == t.length()) {
                if (right - left + 1 < min_len) {
                    min_len = right - left + 1;
                    start_idx = left;
                }

                char char_l = s[left];

                if (t_freq[char_l] > 0) {
                    if (window_freq[char_l] == t_freq[char_l]) {
                        formed_count--;
                    }
                    window_freq[char_l]--;
                } else {
                    window_freq[char_l]--;
                }

                left++;
            }
        }

        if (min_len == std::numeric_limits<int>::max()) {
            return "";
        } else {
            return s.substr(start_idx, min_len);
        }
    }
};