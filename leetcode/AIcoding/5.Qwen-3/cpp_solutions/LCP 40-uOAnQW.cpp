#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int calculate(string s) {
        int n = s.length();
        int result = 0;
        int currentNumber = 0;
        int sign = 1;
        int i = 0;

        while (i < n) {
            char c = s[i];
            if (isdigit(c)) {
                currentNumber = currentNumber * 10 + (c - '0');
                i++;
            } else if (c == '+') {
                result += sign * currentNumber;
                currentNumber = 0;
                sign = 1;
                i++;
            } else if (c == '-') {
                result += sign * currentNumber;
                currentNumber = 0;
                sign = -1;
                i++;
            } else if (c == '(') {
                int j = i + 1;
                int balance = 1;
                while (j < n && balance != 0) {
                    if (s[j] == '(') balance++;
                    else if (s[j] == ')') balance--;
                    j++;
                }
                currentNumber = calculate(s.substr(i + 1, j - i - 2));
                i = j;
            } else {
                i++;
            }
        }

        result += sign * currentNumber;
        return result;
    }
};