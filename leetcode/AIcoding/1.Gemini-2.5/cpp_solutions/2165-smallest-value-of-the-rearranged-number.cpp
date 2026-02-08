#include <string>
#include <algorithm>
#include <vector>

class Solution {
public:
    long long smallestNumber(long long num) {
        if (num == 0) {
            return 0;
        }

        std::string s = std::to_string(num);
        bool is_negative = (num < 0);

        if (is_negative) {
            std::string digits_str = s.substr(1);
            std::sort(digits_str.rbegin(), digits_str.rend());
            return -std::stoll(digits_str);
        } else {
            std::sort(s.begin(), s.end());
            int first_non_zero_idx = 0;
            while (first_non_zero_idx < s.length() && s[first_non_zero_idx] == '0') {
                first_non_zero_idx++;
            }
            std::swap(s[0], s[first_non_zero_idx]);
            return std::stoll(s);
        }
    }
};