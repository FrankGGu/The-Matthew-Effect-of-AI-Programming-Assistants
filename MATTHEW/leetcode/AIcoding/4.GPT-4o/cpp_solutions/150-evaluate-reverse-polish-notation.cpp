#include <vector>
#include <string>
#include <stack>
#include <cctype>

using namespace std;

class Solution {
public:
    int evalRPN(vector<string>& tokens) {
        stack<int> stk;
        for (const string& token : tokens) {
            if (isdigit(token[0]) || (token.size() > 1 && token[0] == '-')) {
                stk.push(stoi(token));
            } else {
                int b = stk.top(); stk.pop();
                int a = stk.top(); stk.pop();
                if (token == "+") stk.push(a + b);
                else if (token == "-") stk.push(a - b);
                else if (token == "*") stk.push(a * b);
                else if (token == "/") stk.push(a / b);
            }
        }
        return stk.top();
    }
};