#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int myAtoi(string s) {
        int i = 0;
        int sign = 1;
        long result = 0;

        while (i < s.length() && s[i] == ' ') {
            i++;
        }

        if (i < s.length() && s[i] == '-') {
            sign = -1;
            i++;
        } else if (i < s.length() && s[i] == '+') {
            i++;
        }

        while (i < s.length() && isdigit(s[i])) {
            result = result * 10 + (s[i] - '0');
            if (sign == 1 && result > INT_MAX) {
                return INT_MAX;
            }
            if (sign == -1 && result > static_cast<long>(INT_MAX) + 1) {
                return INT_MIN;
            }
            i++;
        }

        return static_cast<int>(result * sign);
    }
};