class Solution {
public:
    int calculate(string s) {
        int n = s.size();
        long long num = 0, lastNum = 0, result = 0;
        char operation = '+';

        for (int i = 0; i < n; ++i) {
            if (isdigit(s[i])) {
                num = num * 10 + (s[i] - '0');
            }
            if ((!isdigit(s[i]) && !isspace(s[i])) || i == n - 1) {
                if (operation == '+') {
                    result += lastNum;
                    lastNum = num;
                } else if (operation == '-') {
                    result += lastNum;
                    lastNum = -num;
                } else if (operation == '*') {
                    lastNum *= num;
                } else if (operation == '/') {
                    lastNum /= num;
                }
                operation = s[i];
                num = 0;
            }
        }
        return result + lastNum;
    }
};