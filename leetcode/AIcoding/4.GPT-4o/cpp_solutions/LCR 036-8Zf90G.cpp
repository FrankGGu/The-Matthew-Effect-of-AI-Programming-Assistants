#include <vector>
#include <string>
#include <stack>
#include <unordered_map>

class Solution {
public:
    int evalRPN(std::vector<std::string>& tokens) {
        std::stack<int> s;
        std::unordered_map<std::string, std::function<int(int, int)>> ops = {
            {"+", [](int a, int b) { return a + b; }},
            {"-", [](int a, int b) { return a - b; }},
            {"*", [](int a, int b) { return a * b; }},
            {"/", [](int a, int b) { return a / b; }}
        };

        for (const auto& token : tokens) {
            if (ops.count(token)) {
                int b = s.top(); s.pop();
                int a = s.top(); s.pop();
                s.push(ops[token](a, b));
            } else {
                s.push(std::stoi(token));
            }
        }

        return s.top();
    }
};