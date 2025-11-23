#include <iostream>
#include <vector>
#include <string>
#include <cctype>

using namespace std;

class Solution {
public:
    bool isNumber(string s) {
        bool num = false, exp = false, sign = false, dot = false;
        int n = s.length();
        for (int i = 0; i < n; ++i) {
            char c = s[i];
            if (c == 'e' || c == 'E') {
                if (exp || !num || i == n - 1) return false;
                exp = true;
                num = false;
                sign = false;
                dot = false;
            } else if (c == '+' || c == '-') {
                if (sign || num || i > 0 && s[i-1] != 'e' && s[i-1] != 'E') return false;
                sign = true;
            } else if (c == '.') {
                if (dot || exp) return false;
                dot = true;
            } else if (!isdigit(c)) {
                return false;
            }
            if (isdigit(c)) num = true;
        }
        return num;
    }
};