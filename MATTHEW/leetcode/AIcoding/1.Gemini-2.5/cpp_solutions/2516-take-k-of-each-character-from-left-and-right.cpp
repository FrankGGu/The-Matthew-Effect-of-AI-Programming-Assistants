#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int takeCharacters(std::string s, int k) {
        int n = s.length();

        std::vector<int> total_counts(3, 0); // 0 for 'a', 1 for 'b', 2 for 'c'
        for (char c : s) {
            total_counts[c - 'a']++;
        }

        if (total_counts[0] < k || total_counts[1] < k || total_counts[2] < k) {
            return -1;
        }

        int target_a = total_counts[0] - k;
        int target_b = total_counts[1] - k;
        int target_c = total_counts[2] - k;

        int left = 0;
        std::vector<int> current_window_counts(3, 0);
        int max_len = 0;

        for (int right = 0; right < n; ++right) {
            current_window_counts[s[right] - 'a']++;

            while (current_window_counts[0] > target_a ||
                   current_window_counts[1] > target_b ||
                   current_window_counts[2] > target_c) {

                current_window_counts[s[left] - 'a']--;
                left++;
            }

            max_len = std::max(max_len, right - left + 1);
        }

        return n - max_len;
    }
};