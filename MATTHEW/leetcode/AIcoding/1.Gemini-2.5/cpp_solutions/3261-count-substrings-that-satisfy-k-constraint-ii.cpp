#include <string>
#include <vector>
#include <map>
#include <algorithm>

class Solution {
public:
    long long countSubstringsThatSatisfyKConstraint(std::string s, int k) {
        long long total_ans = 0;
        int n = s.length();

        // Iterate through all possible numbers of distinct characters in a valid substring.
        // A valid substring can have at most 26 distinct characters (a-z).
        for (int num_distinct_target = 1; num_distinct_target <= 26; ++num_distinct_target) {
            std::vector<int> freq(26, 0);
            int left = 0; // Left pointer of the main sliding window [left...right]
            int p = 0;    // Left pointer for counting valid substrings ending at 'right'
            int distinct_count = 0; // Number of distinct characters in the current window [left...right]
            int k_freq_count = 0;   // Number of distinct characters in [left...right] with frequency >= k

            for (int right = 0; right < n; ++right) {
                // Expand the window by including s[right]
                int char_idx = s[right] - 'a';
                if (freq[char_idx] == 0) {
                    distinct_count++;
                }
                freq[char_idx]++;
                if (freq[char_idx] == k) {
                    k_freq_count++;
                }

                // Shrink the window from 'left' if:
                // 1. The number of distinct characters exceeds num_distinct_target.
                // 2. Or, if the number of characters with frequency >= k is less than distinct_count,
                //    meaning some distinct character in the window has frequency < k.
                while (distinct_count > num_distinct_target || k_freq_count < distinct_count) {
                    int char_to_remove_idx = s[left] - 'a';
                    if (freq[char_to_remove_idx] == k) {
                        k_freq_count--;
                    }
                    freq[char_to_remove_idx]--;
                    if (freq[char_to_remove_idx] == 0) {
                        distinct_count--;
                    }
                    left++;
                    // When 'left' moves, 'p' must also move forward, it cannot be behind 'left'.
                    p = std::max(p, left);
                }

                // At this point, the window [left...right] satisfies:
                // 1. distinct_count <= num_distinct_target
                // 2. k_freq_count >= distinct_count (all distinct chars have freq >= k)

                // If the window [left...right] has exactly 'num_distinct_target' distinct characters,
                // and all of them have frequency >= k, then it's a valid window.
                if (distinct_count == num_distinct_target && k_freq_count == num_distinct_target) {
                    // We need to count all valid substrings ending at 'right'.
                    // The 'p' pointer finds the leftmost starting position such that
                    // s[p...right] is still valid. It advances as long as the character s[p]
                    // has a frequency > k in the current window [left...right].
                    // This means removing s[p] would still leave s[p+1...right] with all its
                    // characters having frequency >= k (relative to the original [left...right] window).
                    while (p <= right && freq[s[p] - 'a'] > k) {
                        p++;
                    }
                    // All substrings s[x...right] where x is from 'left' to 'p' are valid.
                    // The number of such substrings is (p - left + 1).
                    total_ans += (p - left + 1);
                }
            }
        }
        return total_ans;
    }
};