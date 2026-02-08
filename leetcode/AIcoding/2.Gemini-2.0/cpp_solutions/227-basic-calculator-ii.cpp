#include <stack>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int calculate(string s) {
        stack<int> nums;
        stack<char> ops;
        int num = 0;

        for (int i = 0; i < s.length(); ++i) {
            if (isdigit(s[i])) {
                num = num * 10 + (s[i] - '0');
            } else if (s[i] != ' ') {
                nums.push(num);
                num = 0;

                while (!ops.empty() && precedence(ops.top()) >= precedence(s[i])) {
                    int num2 = nums.top();
                    nums.pop();
                    int num1 = nums.top();
                    nums.pop();
                    char op = ops.top();
                    ops.pop();
                    nums.push(applyOp(num1, num2, op));
                }
                ops.push(s[i]);
            }
        }

        nums.push(num);

        while (!ops.empty()) {
            int num2 = nums.top();
            nums.pop();
            int num1 = nums.top();
            nums.pop();
            char op = ops.top();
            ops.pop();
            nums.push(applyOp(num1, num2, op));
        }

        return nums.top();
    }

private:
    int precedence(char op) {
        if (op == '+' || op == '-') return 1;
        if (op == '*' || op == '/') return 2;
        return 0;
    }

    int applyOp(int a, int b, char op) {
        switch (op) {
            case '+': return a + b;
            case '-': return a - b;
            case '*': return a * b;
            case '/': return a / b;
            default: return 0;
        }
    }
};