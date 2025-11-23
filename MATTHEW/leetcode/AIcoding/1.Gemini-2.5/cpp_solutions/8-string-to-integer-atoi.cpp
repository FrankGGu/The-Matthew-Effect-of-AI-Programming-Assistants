#include <string>
#include <climits>
#include <cctype>

class Solution {
public:
    int myAtoi(std::string s) {
        int i = 0;
        int n = s.length();

        while (i < n && std::isspace(s[i])) {
            i++;
        }

        int sign = 1;
        if (i < n && s[i] == '-') {
            sign = -1;
            i++;
        } else if (i < n && s[i] == '+') {
            i++;
        }

        long long num = 0;
        while (i < n && std::isdigit(s[i])) {
            int digit = s[i] - '0';

            if (num > INT_MAX / 10 || (num == INT_MAX / 10 && digit > INT_MAX % 10)) {
                return (sign == 1) ? INT_MAX : INT_MIN;
            }

            num = num * 10 + digit;
            i++;
        }

        return num * sign;
    }
};