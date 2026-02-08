#include <string>
#include <vector>
#include <cctype>
#include <bitset>
#include <algorithm> // For std::max

class Solution {
public:
    std::string longestNiceSubstring(std::string s) {
        if (s.length() < 2) {
            return "";
        }

        std::bitset<26> lower_present;
        std::bitset<26> upper_present;

        for (char c : s) {
            if (std::islower(c)) {
                lower_present[c - 'a'] = true;
            } else {
                upper_present[c - 'A'] = true;
            }
        }

        int bad_char_idx = -1;
        for (int i = 0; i < s.length(); ++i) {
            char c = s[i];
            if (std::islower(c)) {
                if (!upper_present[c - 'a']) {
                    bad_char_idx = i;
                    break;
                }
            } else { // isupper(c)
                if (!lower_present[c - 'A']) {
                    bad_char_idx = i;
                    break;
                }
            }
        }

        if (bad_char_idx == -1) {
            return s;
        }

        std::string left_res = longestNiceSubstring(s.substr(0, bad_char_idx));
        std::string right_res = longestNiceSubstring(s.substr(bad_char_idx + 1));

        if (left_res.length() >= right_res.length()) {
            return left_res;
        } else {
            return right_res;
        }
    }
};