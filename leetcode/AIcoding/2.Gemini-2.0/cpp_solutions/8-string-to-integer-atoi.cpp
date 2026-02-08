#include <string>
#include <climits>

class Solution {
public:
    int myAtoi(std::string s) {
        int sign = 1;
        int result = 0;
        int index = 0;
        int n = s.length();

        while (index < n && s[index] == ' ') {
            index++;
        }

        if (index < n && (s[index] == '+' || s[index] == '-')) {
            sign = (s[index] == '-') ? -1 : 1;
            index++;
        }

        while (index < n && isdigit(s[index])) {
            int digit = s[index] - '0';

            if (result > INT_MAX / 10 || (result == INT_MAX / 10 && digit > INT_MAX % 10)) {
                return (sign == 1) ? INT_MAX : INT_MIN;
            }

            result = result * 10 + digit;
            index++;
        }

        return sign * result;
    }
};