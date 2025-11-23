#include <iostream>
#include <vector>
#include <string>

class Solution {
public:
    std::string reformat(std::string s) {
        std::vector<char> letters;
        std::vector<char> digits;
        for (char c : s) {
            if (isalpha(c)) {
                letters.push_back(c);
            } else {
                digits.push_back(c);
            }
        }
        if (abs((int)letters.size() - (int)digits.size()) > 1) {
            return "";
        }
        std::string result;
        int i = 0, j = 0;
        if (letters.size() > digits.size()) {
            while (i < letters.size()) {
                result += letters[i++];
                if (j < digits.size()) {
                    result += digits[j++];
                }
            }
        } else {
            while (j < digits.size()) {
                result += digits[j++];
                if (i < letters.size()) {
                    result += letters[i++];
                }
            }
        }
        return result;
    }
};