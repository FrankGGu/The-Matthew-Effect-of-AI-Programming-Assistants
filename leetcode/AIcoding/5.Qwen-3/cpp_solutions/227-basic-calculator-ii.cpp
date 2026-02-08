#include <iostream>
#include <vector>
#include <cctype>

using namespace std;

class Solution {
public:
    int calculate(string s) {
        int n = s.size();
        int currentNumber = 0;
        int result = 0;
        int sign = '+';

        for (int i = 0; i < n; i++) {
            char c = s[i];
            if (isdigit(c)) {
                currentNumber = currentNumber * 10 + (c - '0');
            }

            if (!isdigit(c) && c != ' ' || i == n - 1) {
                if (sign == '+') {
                    result += currentNumber;
                } else if (sign == '-') {
                    result -= currentNumber;
                } else if (sign == '*') {
                    result *= currentNumber;
                } else if (sign == '/') {
                    result /= currentNumber;
                }

                sign = c;
                currentNumber = 0;
            }
        }

        return result;
    }
};