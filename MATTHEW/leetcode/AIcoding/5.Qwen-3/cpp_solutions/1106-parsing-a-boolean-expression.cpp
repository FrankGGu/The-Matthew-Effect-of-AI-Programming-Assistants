#include <iostream>
#include <vector>
#include <stack>
#include <string>

using namespace std;

class Solution {
public:
    bool parseBoolExpr(string expression) {
        stack<char> s;
        for (char c : expression) {
            if (c == 't' || c == 'f' || c == '!' || c == '&' || c == '|' || c == '(' || c == ')') {
                if (c == ')') {
                    stack<char> temp;
                    while (s.top() != '(') {
                        temp.push(s.top());
                        s.pop();
                    }
                    s.pop();                     char op = s.top();
                    s.pop();
                    bool result = false;
                    if (op == '!') {
                        result = (temp.top() == 'f');
                    } else {
                        bool val1 = (temp.top() == 't');
                        temp.pop();
                        if (op == '&') {
                            result = val1;
                            while (!temp.empty()) {
                                bool val2 = (temp.top() == 't');
                                result &= val2;
                                temp.pop();
                            }
                        } else if (op == '|') {
                            result = val1;
                            while (!temp.empty()) {
                                bool val2 = (temp.top() == 't');
                                result |= val2;
                                temp.pop();
                            }
                        }
                    }
                    s.push(result ? 't' : 'f');
                } else {
                    s.push(c);
                }
            }
        }
        return s.top() == 't';
    }
};