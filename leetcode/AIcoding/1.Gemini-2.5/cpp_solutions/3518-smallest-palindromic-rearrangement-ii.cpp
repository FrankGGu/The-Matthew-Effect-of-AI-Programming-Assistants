#include <string>
#include <vector>
#include <algorithm>
#include <map>

class Solution {
public:
    std::string smallestPalindromicRearrangement(std::string s) {
        std::map<char, int> freq;
        for (char c : s) {
            freq[c]++;
        }

        char odd_char = '\0';
        int odd_count_chars = 0;
        for (auto const& pair : freq) {
            if (pair.second % 2 != 0) {
                odd_char = pair.first;
                odd_count_chars++;
            }
        }

        if (odd_count_chars > 1) {
            return "";
        }

        std::string first_half = "";
        for (auto const& pair : freq) {
            first_half.append(pair.second / 2, pair.first);
        }

        std::string result = first_half;
        if (odd_char != '\0') {
            result += odd_char;
        }
        std::string second_half = first_half;
        std::reverse(second_half.begin(), second_half.end());
        result += second_half;

        return result;
    }
};