#include <iostream>
#include <vector>
#include <stack>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minCost(string expression) {
        stack<int> nums;
        stack<char> ops;

        auto apply = [&](int a, int b, char op) {
            if (op == '+') return a + b;
            else return a * b;
        };

        auto cost = [&](int a, int b, char op) {
            if (op == '+') return 1;
            else return 1;
        };

        for (int i = 0; i < expression.length(); ++i) {
            if (expression[i] == ' ') continue;
            if (isdigit(expression[i])) {
                nums.push(expression[i] - '0');
            } else if (expression[i] == '(') {
                ops.push(expression[i]);
            } else if (expression[i] == ')') {
                while (ops.top() != '(') {
                    int b = nums.top(); nums.pop();
                    int a = nums.top(); nums.pop();
                    int res = apply(a, b, ops.top()); nums.push(res);
                    ops.pop();
                }
                ops.pop();
            } else {
                while (!ops.empty() && ops.top() != '(' && precedence(ops.top()) >= precedence(expression[i])) {
                    int b = nums.top(); nums.pop();
                    int a = nums.top(); nums.pop();
                    int res = apply(a, b, ops.top()); nums.push(res);
                    ops.pop();
                }
                ops.push(expression[i]);
            }
        }

        while (!ops.empty()) {
            int b = nums.top(); nums.pop();
            int a = nums.top(); nums.pop();
            int res = apply(a, b, ops.top()); nums.push(res);
            ops.pop();
        }

        return nums.top();
    }

private:
    int precedence(char op) {
        if (op == '+') return 1;
        if (op == '*') return 2;
        return 0;
    }
};