#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    std::string greatestLetter(std::string s) {
        std::vector<bool> lower(26, false);
        std::vector<bool> upper(26, false);

        for (char c : s) {
            if (islower(c)) {
                lower[c - 'a'] = true;
            } else {
                upper[c - 'A'] = true;
            }
        }

        std::string result;
        for (int i = 25; i >= 0; --i) {
            if (lower[i] && upper[i]) {
                return std::string(1, 'A' + i);
            }
        }

        return "";
    }
};