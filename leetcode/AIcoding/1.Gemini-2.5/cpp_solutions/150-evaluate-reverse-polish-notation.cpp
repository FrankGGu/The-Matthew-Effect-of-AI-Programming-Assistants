#include <vector>
#include <string>
#include <stack>
#include <stdexcept>

class Solution {
public:
    int evalRPN(std::vector<std::string>& tokens) {
        std::stack<long long> s;

        for (const std::string& token : tokens) {
            if (token == "+" || token == "-" || token == "*" || token == "/") {
                long long operand2 = s.top();
                s.pop();
                long long operand1 = s.top();
                s.pop();

                if (token == "+") {
                    s.push(operand1 + operand2);
                } else if (token == "-") {
                    s.push(operand1 - operand2);
                } else if (token == "*") {
                    s.push(operand1 * operand2);
                } else if (token == "/") {
                    s.push(operand1 / operand2);
                }
            } else {
                s.push(std::stoll(token));
            }
        }

        return static_cast<int>(s.top());
    }
};