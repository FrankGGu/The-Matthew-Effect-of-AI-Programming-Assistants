class Solution {
public:
    int calculate(string s) {
        int len = s.size(), currentNumber = 0, result = 0, lastNumber = 0;
        char operation = '+';
        for (int i = 0; i < len; i++) {
            if (isdigit(s[i])) {
                currentNumber = currentNumber * 10 + (s[i] - '0');
            }
            if (!isdigit(s[i]) && !isspace(s[i]) || i == len - 1) {
                if (operation == '+') {
                    result += lastNumber;
                    lastNumber = currentNumber;
                } else if (operation == '-') {
                    result += lastNumber;
                    lastNumber = -currentNumber;
                } else if (operation == '*') {
                    lastNumber *= currentNumber;
                } else if (operation == '/') {
                    lastNumber /= currentNumber;
                }
                operation = s[i];
                currentNumber = 0;
            }
        }
        result += lastNumber;
        return result;
    }
};