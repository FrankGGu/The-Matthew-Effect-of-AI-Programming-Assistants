class Solution {
public:
    int calculate(string s) {
        int n = s.size();
        long long result = 0, currentNumber = 0;
        char operation = '+';

        for (int i = 0; i < n; ++i) {
            if (isdigit(s[i])) {
                currentNumber = currentNumber * 10 + (s[i] - '0');
            }
            if (!isdigit(s[i]) && !isspace(s[i]) || i == n - 1) {
                if (operation == '+') {
                    result += currentNumber;
                } else if (operation == '-') {
                    result -= currentNumber;
                } else if (operation == '*') {
                    result *= currentNumber;
                } else if (operation == '/') {
                    result /= currentNumber;
                }
                operation = s[i];
                currentNumber = 0;
            }
        }

        return result;
    }
};