#include <string>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    int minOperationsToFlip(string expression) {
        function<pair<int, int>(int, int)> solve = [&](int l, int r) {
            if (l == r) {
                return make_pair(0, 0);
            }

            stack<int> ops;
            stack<pair<int, int>> vals;
            int i = l;

            while (i <= r) {
                if (expression[i] == '(') {
                    int j = i + 1;
                    int cnt = 1;
                    while (j <= r) {
                        if (expression[j] == '(') cnt++;
                        if (expression[j] == ')') cnt--;
                        if (cnt == 0) break;
                        j++;
                    }
                    vals.push(solve(i + 1, j - 1));
                    i = j + 1;
                } else if (isdigit(expression[i])) {
                    vals.push({0, 0});
                    i++;
                } else {
                    while (!ops.empty() && precedence(ops.top(), expression[i]) >= 0) {
                        calculate(ops, vals);
                    }
                    ops.push(expression[i]);
                    i++;
                }
            }

            while (!ops.empty()) {
                calculate(ops, vals);
            }

            return vals.top();
        };

        return min(solve(0, expression.size() - 1).first, solve(0, expression.size() - 1).second);
    }

private:
    int precedence(int op1, int op2) {
        if (op1 == '(' || op2 == '(' || op2 == ')') return -1;
        if (op1 == ')') return 1;
        return 0;
    }

    void calculate(stack<int>& ops, stack<pair<int, int>>& vals) {
        int op = ops.top();
        ops.pop();

        pair<int, int> v2 = vals.top();
        vals.pop();
        pair<int, int> v1 = vals.top();
        vals.pop();

        if (op == '&') {
            vals.push({min(v1.first, v2.first + 1), min(v2.second, v1.second + 1)});
        } else {
            vals.push({min(v1.first + 1, v2.first), min(v1.second + 1, v2.second)});
        }
    }
};