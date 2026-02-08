#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::string greatestLetter(std::string s) {
        std::vector<bool> lower(26, false);
        std::vector<bool> upper(26, false);

        for (char c : s) {
            if (c >= 'a' && c <= 'z') {
                lower[c - 'a'] = true;
            } else if (c >= 'A' && c <= 'Z') {
                upper[c - 'A'] = true;
            }
        }

        for (int i = 25; i >= 0; --i) {
            if (lower[i] && upper[i]) {
                return std::string(1, (char)('A' + i));
            }
        }

        return "";
    }
};