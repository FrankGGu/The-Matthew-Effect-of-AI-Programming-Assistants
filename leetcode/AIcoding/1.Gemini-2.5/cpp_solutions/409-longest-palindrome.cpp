#include <string>
#include <vector>

class Solution {
public:
    int longestPalindrome(std::string s) {
        std::vector<int> char_counts(128, 0);
        for (char c : s) {
            char_counts[c]++;
        }

        int length = 0;
        bool has_odd_count = false;

        for (int count : char_counts) {
            length += (count / 2) * 2;
            if (count % 2 == 1) {
                has_odd_count = true;
            }
        }

        if (has_odd_count) {
            length += 1;
        }

        return length;
    }
};