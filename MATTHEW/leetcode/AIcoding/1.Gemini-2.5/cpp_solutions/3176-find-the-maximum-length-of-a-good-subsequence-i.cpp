#include <string>
#include <vector>
#include <algorithm> // For std::max

class Solution {
public:
    int maximumLength(std::string s, std::string t) {
        int n = s.length();

        // max_len_ending_with[char_idx] stores the maximum length of a good subsequence
        // that ends with the character ('a' + char_idx).
        std::vector<int> max_len_ending_with(26, 0);

        // max1_val: The largest length found so far among all ending characters.
        // max1_char_idx: The character index corresponding to max1_val.
        // max2_val: The second largest length found so far.
        int max1_val = 0;
        int max1_char_idx = -1;
        int max2_val = 0;

        int max_overall_len = 0;

        for (int i = 0; i < n; ++i) {
            int idx_s = s[i] - 'a';
            int idx_t = t[i] - 'a';

            // Calculate potential length if we pick s[i]
            // The previous character in the subsequence must be different from s[i].
            // So, we take the maximum length from `max_len_ending_with` that does not end with s[i].
            int len_s_i = 1;
            if (idx_s == max1_char_idx) {
                len_s_i += max2_val;
            } else {
                len_s_i += max1_val;
            }

            // Calculate potential length if we pick t[i]
            // The previous character in the subsequence must be different from t[i].
            int len_t_i = 1;
            if (idx_t == max1_char_idx) {
                len_t_i += max2_val;
            } else {
                len_t_i += max1_val;
            }

            // Store the values that `max_len_ending_with` would take if updated.
            // These are based on max1_val/max2_val from the *start* of the current iteration.
            int new_val_for_s_char = std::max(max_len_ending_with[idx_s], len_s_i);
            int new_val_for_t_char = std::max(max_len_ending_with[idx_t], len_t_i);

            // Update max_len_ending_with for idx_s and idx_t
            // Note: if idx_s == idx_t, the second update will correctly take the max of the two.
            max_len_ending_with[idx_s] = new_val_for_s_char;
            max_len_ending_with[idx_t] = new_val_for_t_char;

            // Update overall maximum length
            max_overall_len = std::max({max_overall_len, new_val_for_s_char, new_val_for_t_char});

            // Re-calculate max1_val, max1_char_idx, max2_val for the next iteration
            // This step is O(26) but performed N times, leading to an overall O(N) solution.
            max1_val = 0;
            max1_char_idx = -1;
            max2_val = 0;

            for (int k = 0; k < 26; ++k) {
                if (max_len_ending_with[k] > max1_val) {
                    max2_val = max1_val;
                    max1_val = max_len_ending_with[k];
                    max1_char_idx = k;
                } else if (max_len_ending_with[k] > max2_val) {
                    max2_val = max_len_ending_with[k];
                }
            }
        }

        return max_overall_len;
    }
};