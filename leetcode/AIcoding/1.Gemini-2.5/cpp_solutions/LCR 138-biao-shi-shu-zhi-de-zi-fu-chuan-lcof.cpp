#include <string>
#include <cctype>

class Solution {
public:
    bool isNumber(std::string s) {
        int i = 0;
        int n = s.length();

        while (i < n && s[i] == ' ') {
            i++;
        }

        if (i < n && (s[i] == '+' || s[i] == '-')) {
            i++;
        }

        bool digit_seen = false;
        bool dot_seen = false;

        while (i < n) {
            if (std::isdigit(s[i])) {
                digit_seen = true;
                i++;
            } else if (s[i] == '.') {
                if (dot_seen) {
                    return false;
                }
                dot_seen = true;
                i++;
            } else {
                break;
            }
        }

        if (!digit_seen) {
            return false;
        }

        if (i < n && (s[i] == 'e' || s[i] == 'E')) {
            i++;

            bool exp_digit_seen = false;

            if (i < n && (s[i] == '+' || s[i] == '-')) {
                i++;
            }

            while (i < n && std::isdigit(s[i])) {
                exp_digit_seen = true;
                i++;
            }

            if (!exp_digit_seen) {
                return false;
            }
        }

        while (i < n && s[i] == ' ') {
            i++;
        }

        return i == n;
    }
};