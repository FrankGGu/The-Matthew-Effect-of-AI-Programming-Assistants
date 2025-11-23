#include <string>
#include <vector>

class Solution {
public:
    long long countSubstrings(std::string s) {
        long long ans = 0;
        int n = s.length();

        // Frequencies of 'a', 'b', 'c' in the current window [left, right]
        // freq[0] for 'a', freq[1] for 'b', freq[2] for 'c'
        std::vector<int> freq(3, 0); 

        int left = 0;
        for (int right = 0; right < n; ++right) {
            // Add s[right] to the window
            if (s[right] == 'a') {
                freq[0]++;
            } else if (s[right] == 'b') {
                freq[1]++;
            } else if (s[right] == 'c') {
                freq[2]++;
            }

            // While the current window [left, right] contains at least one 'a', 'b', and 'c'
            while (freq[0] >= 1 && freq[1] >= 1 && freq[2] >= 1) {
                // If s[left...right] is a valid substring, then s[left+1...right] might also be valid,
                // but s[left-1...right] (if left > 0) is definitely valid.
                // We want to find the smallest `left` such that `s[left...right]` is valid.
                // Once found, all substrings `s[0...right], s[1...right], ..., s[left...right]`
                // are valid. The count of such substrings is `left + 1`.
                // However, the standard two-pointer approach counts `left` for each `right`.
                // This `left` represents the number of valid starting positions for substrings ending at `right`.

                // Remove s[left] from the window to try to shrink it
                if (s[left] == 'a') {
                    freq[0]--;
                } else if (s[left] == 'b') {
                    freq[1]--;
                } else if (s[left] == 'c') {
                    freq[2]--;
                }
                left++;
            }
            // After the while loop, `left` points to the first index such that `s[left...right]`
            // does NOT satisfy the condition (or `left` is past `right`).
            // This means `s[0...right]`, `s[1...right]`, ..., `s[left-1...right]` are all valid.
            // The number of such substrings is `left`.
            // So, for each `right`, we add `left` to the total count.
            ans += left;
        }

        return ans;
    }
};