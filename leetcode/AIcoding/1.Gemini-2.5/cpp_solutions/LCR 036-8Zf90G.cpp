#include <vector>
#include <string>
#include <stack>

using namespace std;

class Solution {
public:
    int evalRPN(vector<string>& tokens) {
        stack<long long> s;
        for (const string& token : tokens) {
            if (token == "+") {
                long long op2 = s.top(); s.pop();
                long long op1 = s.top(); s.pop();
                s.push(op1 + op2);
            } else if (token == "-") {
                long long op2 = s.top(); s.pop();
                long long op1 = s.top(); s.pop();
                s.push(op1 - op2);
            } else if (token == "*") {
                long long op2 = s.top(); s.pop();
                long long op1 = s.top(); s.pop();
                s.push(op1 * op2);
            } else if (token == "/") {
                long long op2 = s.top(); s.pop();
                long long op1 = s.top(); s.pop();
                s.push(op1 / op2);
            } else {
                s.push(stoll(token));
            }
        }
        return static_cast<int>(s.top());
    }
};