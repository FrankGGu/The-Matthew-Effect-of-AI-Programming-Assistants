#include <string>
#include <limits> // For std::numeric_limits
#include <cctype> // For std::isdigit

class Solution {
public:
    int myAtoi(std::string s) {
        int i = 0;
        int n = s.length();

        while (i < n && s[i] == ' ') {
            i++;
        }

        if (i == n) {
            return 0;
        }

        int sign = 1;
        if (s[i] == '-') {
            sign = -1;
            i++;
        } else if (s[i] == '+') {
            i++;
        }

        long long result = 0;

        int int_max = std::numeric_limits<int>::max();
        int int_min = std::numeric_limits<int>::min();

        while (i < n && std::isdigit(s[i])) {
            int digit = s[i] - '0';

            if (sign == 1) {
                if (result > int_max / 10 || (result == int_max / 10 && digit > int_max % 10)) {
                    return int_max;
                }
            } else {
                if (result > (static_cast<long long>(int_max) + 1) / 10 || 
                    (result == (static_cast<long long>(int_max) + 1) / 10 && digit > (static_cast<long long>(int_max) + 1) % 10)) {
                    return int_min;
                }
            }

            result = result * 10 + digit;
            i++;
        }

        result *= sign;

        if (result > int_max) {
            return int_max;
        }
        if (result < int_min) {
            return int_min;
        }

        return static_cast<int>(result);
    }
};