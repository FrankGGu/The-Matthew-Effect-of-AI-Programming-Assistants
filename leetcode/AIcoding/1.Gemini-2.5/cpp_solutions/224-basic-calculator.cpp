#include <string>
#include <stack>
#include <cctype>

class Solution {
public:
    int calculate(std::string s) {
        std::stack<int> signs_stack;
        int result = 0;
        int sign = 1;
        int current_num = 0;

        for (char c : s) {
            if (std::isdigit(c)) {
                current_num = current_num * 10 + (c - '0');
            } else if (c == '+') {
                result += sign * current_num;
                current_num = 0;
                sign = 1;
            } else if (c == '-') {
                result += sign * current_num;
                current_num = 0;
                sign = -1;
            } else if (c == '(') {
                signs_stack.push(result);
                signs_stack.push(sign);
                result = 0;
                sign = 1;
            } else if (c == ')') {
                result += sign * current_num;
                current_num = 0;
                result *= signs_stack.top();
                signs_stack.pop();
                result += signs_stack.top();
                signs_stack.pop();
            }
        }

        result += sign * current_num;

        return result;
    }
};