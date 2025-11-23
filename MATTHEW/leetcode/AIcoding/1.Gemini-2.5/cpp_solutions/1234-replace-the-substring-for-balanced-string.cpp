#include <string>
#include <vector>
#include <map>
#include <algorithm>

class Solution {
public:
    int char_to_int(char c) {
        if (c == 'Q') return 0;
        if (c == 'W') return 1;
        if (c == 'E') return 2;
        return 3; // 'R'
    }

    int balancedString(std::string s) {
        int n = s.length();
        int k = n / 4;

        std::vector<int> total_freq(4, 0);
        for (char c : s) {
            total_freq[char_to_int(c)]++;
        }

        std::vector<int> excess_needed(4, 0);
        bool already_balanced = true;
        int num_excess_char_types = 0;

        for (int i = 0; i < 4; ++i) {
            if (total_freq[i] > k) {
                excess_needed[i] = total_freq[i] - k;
                already_balanced = false;
                num_excess_char_types++;
            }
        }

        if (already_balanced) {
            return 0;
        }

        int left = 0;
        int min_len = n;
        std::vector<int> window_freq(4, 0);
        int count_satisfied_chars_types = 0;

        for (int right = 0; right < n; ++right) {
            int r_idx = char_to_int(s[right]);
            window_freq[r_idx]++;

            // If this character type was in excess and its count in the window
            // now meets the required excess, increment the satisfied count.
            if (excess_needed[r_idx] > 0 && window_freq[r_idx] == excess_needed[r_idx]) {
                count_satisfied_chars_types++;
            }

            // While all excess character types are satisfied by the current window
            while (count_satisfied_chars_types == num_excess_char_types) {
                min_len = std::min(min_len, right - left + 1);

                int l_idx = char_to_int(s[left]);
                // If this character type was in excess and its count in the window
                // was exactly the required excess, decrement the satisfied count
                // as we are removing one instance from the left.
                if (excess_needed[l_idx] > 0 && window_freq[l_idx] == excess_needed[l_idx]) {
                    count_satisfied_chars_types--;
                }
                window_freq[l_idx]--;
                left++;
            }
        }

        return min_len;
    }
};