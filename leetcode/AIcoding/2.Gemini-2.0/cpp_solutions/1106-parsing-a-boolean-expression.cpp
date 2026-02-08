#include <stack>
#include <string>

using namespace std;

class Solution {
public:
    bool parseBoolExpr(string expression) {
        stack<char> ops;
        stack<char> values;

        for (char c : expression) {
            if (c == ',') continue;
            else if (c == '(') continue;
            else if (c == 't' || c == 'f') values.push(c);
            else if (c == '!' || c == '&' || c == '|') ops.push(c);
            else if (c == ')') {
                char op = ops.top();
                ops.pop();

                bool result;
                if (op == '!') {
                    result = (values.top() == 'f');
                    values.pop();
                } else if (op == '&') {
                    result = true;
                    while (!values.empty()) {
                        result = result && (values.top() == 't');
                        values.pop();
                    }
                } else {
                    result = false;
                    while (!values.empty()) {
                        result = result || (values.top() == 't');
                        values.pop();
                    }
                }

                values.push(result ? 't' : 'f');
            }
        }

        return values.top() == 't';
    }
};