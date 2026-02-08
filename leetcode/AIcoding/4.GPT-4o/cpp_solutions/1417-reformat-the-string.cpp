#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::string reformat(std::string s) {
        std::vector<char> letters, digits;
        for (char c : s) {
            if (isalpha(c)) letters.push_back(c);
            else digits.push_back(c);
        }

        if (std::abs((int)letters.size() - (int)digits.size()) > 1) return "";

        std::string result;
        bool useLetter = letters.size() >= digits.size();
        int i = 0, j = 0;

        while (i < letters.size() || j < digits.size()) {
            if (useLetter && i < letters.size()) {
                result += letters[i++];
            } else if (j < digits.size()) {
                result += digits[j++];
            }
            useLetter = !useLetter;
        }

        return result;
    }
};