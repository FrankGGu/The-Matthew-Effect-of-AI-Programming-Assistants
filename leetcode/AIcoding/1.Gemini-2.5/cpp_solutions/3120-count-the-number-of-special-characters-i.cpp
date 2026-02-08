#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    int numberOfSpecialChars(std::string s) {
        std::vector<bool> lower_present(26, false);
        std::vector<bool> upper_present(26, false);

        for (char c : s) {
            if (c >= 'a' && c <= 'z') {
                lower_present[c - 'a'] = true;
            } else if (c >= 'A' && c <= 'Z') {
                upper_present[c - 'A'] = true;
            }
        }

        int special_count = 0;
        for (int i = 0; i < 26; ++i) {
            if (lower_present[i] && upper_present[i]) {
                special_count++;
            }
        }

        return special_count;
    }
};