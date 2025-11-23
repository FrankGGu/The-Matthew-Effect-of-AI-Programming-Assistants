#include <string>
#include <cctype> // For std::isdigit

class Solution {
public:
    std::string reformatNumber(std::string s) {
        std::string digits_only;
        for (char c : s) {
            if (std::isdigit(c)) {
                digits_only += c;
            }
        }

        std::string result = "";
        int n = digits_only.length();
        int current_idx = 0;

        while (current_idx < n) {
            int remaining_digits = n - current_idx;

            if (remaining_digits > 4) {
                result += digits_only.substr(current_idx, 3);
                current_idx += 3;
                result += '-';
            } else if (remaining_digits == 4) {
                result += digits_only.substr(current_idx, 2);
                result += '-';
                result += digits_only.substr(current_idx + 2, 2);
                current_idx += 4;
            } else if (remaining_digits == 3) {
                result += digits_only.substr(current_idx, 3);
                current_idx += 3;
            } else if (remaining_digits == 2) {
                result += digits_only.substr(current_idx, 2);
                current_idx += 2;
            }
        }

        return result;
    }
};