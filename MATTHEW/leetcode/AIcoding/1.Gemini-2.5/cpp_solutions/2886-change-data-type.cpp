class Solution {
public:
    int myAtoi(std::string s) {
        long long result = 0;
        int sign = 1;
        int i = 0;
        int n = s.length();

        while (i < n && s[i] == ' ') {
            i++;
        }

        if (i < n && (s[i] == '+' || s[i] == '-')) {
            sign = (s[i] == '-') ? -1 : 1;
            i++;
        }

        while (i < n && std::isdigit(s[i])) {
            result = result * 10 + (s[i] - '0');
            if (sign == 1 && result > INT_MAX) {
                return INT_MAX;
            }
            if (sign == -1 && result * -1 < INT_MIN) {
                return INT_MIN;
            }
            i++;
        }

        return static_cast<int>(result * sign);
    }
};