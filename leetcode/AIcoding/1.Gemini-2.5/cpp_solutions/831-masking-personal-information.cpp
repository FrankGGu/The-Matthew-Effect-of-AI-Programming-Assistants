#include <string>
#include <vector>
#include <algorithm>
#include <cctype>

class Solution {
public:
    std::string maskPII(std::string s) {
        size_t at_pos = s.find('@');
        if (at_pos != std::string::npos) {
            for (char &c : s) {
                c = std::tolower(c);
            }
            std::string result = "";
            result += s[0];
            result += "*****";
            result += s[at_pos - 1];
            result += s.substr(at_pos);
            return result;
        } else {
            std::string digits = "";
            for (char c : s) {
                if (std::isdigit(c)) {
                    digits += c;
                }
            }

            std::string result = "";
            int num_digits = digits.length();
            int country_code_len = num_digits - 10;

            if (country_code_len > 0) {
                result += '+';
                for (int i = 0; i < country_code_len; ++i) {
                    result += '*';
                }
                result += '-';
            }

            result += "***-***-";
            result += digits.substr(num_digits - 4);
            return result;
        }
    }
};