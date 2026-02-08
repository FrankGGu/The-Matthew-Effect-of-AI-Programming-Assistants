#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string reformat(string s) {
        string digits = "";
        string letters = "";
        for (char c : s) {
            if (isdigit(c)) {
                digits += c;
            } else {
                letters += c;
            }
        }

        if (abs((int)digits.length() - (int)letters.length()) > 1) {
            return "";
        }

        string result = "";
        if (digits.length() > letters.length()) {
            for (int i = 0; i < letters.length(); ++i) {
                result += digits[i];
                result += letters[i];
            }
            result += digits[letters.length()];
        } else if (letters.length() > digits.length()) {
            for (int i = 0; i < digits.length(); ++i) {
                result += letters[i];
                result += digits[i];
            }
            result += letters[digits.length()];
        } else {
            for (int i = 0; i < digits.length(); ++i) {
                result += letters[i];
                result += digits[i];
            }
        }

        return result;
    }
};