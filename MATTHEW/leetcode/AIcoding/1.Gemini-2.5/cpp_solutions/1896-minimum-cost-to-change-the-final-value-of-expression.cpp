#include <iostream>
#include <string>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    int minOperationsToFlip(string expression) {
        function<pair<int, int>(int, int)> calculate = 
            [&](int start, int end) -> pair<int, int> {
            if (start == end) {
                return {0, 1};
            }

            vector<char> ops;
            vector<pair<int, int>> nums;
            stack<char> opStack;

            for (int i = start; i <= end; ++i) {
                if (expression[i] == '(') {
                    opStack.push('(');
                } else if (expression[i] == ')') {
                    opStack.pop();
                } else if (expression[i] == '&' || expression[i] == '|') {
                    if (opStack.empty()) {
                        ops.push_back(expression[i]);
                    }
                } else {
                    if (opStack.empty()) {
                        if (expression[i] == '0') {
                            nums.push_back({0, 1});
                        } else {
                            nums.push_back({1, 0});
                        }
                    }
                }
            }

            int n = nums.size();
            if (n == 1) {
                return nums[0];
            }

            vector<pair<int, int>> dp(n);
            dp[0] = nums[0];

            for (int i = 0; i < n - 1; ++i) {
                char op = ops[i];
                pair<int, int> nextNum = nums[i + 1];
                pair<int, int> prevDp = dp[i];

                pair<int, int> currDp;
                if (op == '&') {
                    currDp.first = min(prevDp.first + nextNum.first,
                                       min(prevDp.first + 1, nextNum.first + 1));
                    currDp.second = min(prevDp.first + nextNum.second,
                                        min(prevDp.second + nextNum.first, prevDp.second + nextNum.second));

                } else {
                    currDp.first = min(prevDp.first + nextNum.second,
                                        min(prevDp.first + nextNum.first, prevDp.second + nextNum.second));
                    currDp.second = min(prevDp.second + nextNum.first,
                                       min(prevDp.second + 1, nextNum.first + 1));
                }
                dp[i + 1] = currDp;
            }

            return dp[n - 1];
        };

        stack<int> numStack;
        stack<char> opStack;

        for (int i = 0; i < expression.size(); ++i) {
            if (expression[i] == '(') {
                opStack.push(expression[i]);
            } else if (expression[i] == ')') {
                while (opStack.top() != '(') {
                    char op = opStack.top();
                    opStack.pop();

                    pair<int, int> num2 = {numStack.top() / 1000, numStack.top() % 1000};
                    numStack.pop();
                    pair<int, int> num1 = {numStack.top() / 1000, numStack.top() % 1000};
                    numStack.pop();

                    pair<int, int> currNum;
                    if (op == '&') {
                        currNum.first = min(num1.first + num2.first,
                                           min(num1.first + 1, num2.first + 1));
                        currNum.second = min(num1.first + num2.second,
                                            min(num1.second + num2.first, num1.second + num2.second));
                    } else {
                        currNum.first = min(num1.first + num2.second,
                                            min(num1.first + num2.first, num1.second + num2.second));
                        currNum.second = min(num1.second + num2.first,
                                           min(num1.second + 1, num2.first + 1));
                    }
                    numStack.push(currNum.first * 1000 + currNum.second);
                }
                opStack.pop();
            } else if (expression[i] == '&' || expression[i] == '|') {
                while (!opStack.empty() && opStack.top() != '(') {
                    char op = opStack.top();
                    opStack.pop();

                    pair<int, int> num2 = {numStack.top() / 1000, numStack.top() % 1000};
                    numStack.pop();
                    pair<int, int> num1 = {numStack.top() / 1000, numStack.top() % 1000};
                    numStack.pop();

                    pair<int, int> currNum;
                    if (op == '&') {
                        currNum.first = min(num1.first + num2.first,
                                           min(num1.first + 1, num2.first + 1));
                        currNum.second = min(num1.first + num2.second,
                                            min(num1.second + num2.first, num1.second + num2.second));
                    } else {
                        currNum.first = min(num1.first + num2.second,
                                            min(num1.first + num2.first, num1.second + num2.second));
                        currNum.second = min(num1.second + num2.first,
                                           min(num1.second + 1, num2.first + 1));
                    }
                    numStack.push(currNum.first * 1000 + currNum.second);
                }
                opStack.push(expression[i]);
            } else {
                if (expression[i] == '0') {
                    numStack.push(0 * 1000 + 1);
                } else {
                    numStack.push(1 * 1000 + 0);
                }
            }
        }

        while (!opStack.empty()) {
            char op = opStack.top();
            opStack.pop();

            pair<int, int> num2 = {numStack.top() / 1000, numStack.top() % 1000};
            numStack.pop();
            pair<int, int> num1 = {numStack.top() / 1000, numStack.top() % 1000};
            numStack.pop();

            pair<int, int> currNum;
            if (op == '&') {
                currNum.first = min(num1.first + num2.first,
                                   min(num1.first + 1, num2.first + 1));
                currNum.second = min(num1.first + num2.second,
                                    min(num1.second + num2.first, num1.second + num2.second));
            } else {
                currNum.first = min(num1.first + num2.second,
                                    min(num1.first + num2.first, num1.second + num2.second));
                currNum.second = min(num1.second + num2.first,
                                   min(num1.second + 1, num2.first + 1));
            }
            numStack.push(currNum.first * 1000 + currNum.second);
        }

        return min(numStack.top() / 1000, numStack.top() % 1000);
    }
};