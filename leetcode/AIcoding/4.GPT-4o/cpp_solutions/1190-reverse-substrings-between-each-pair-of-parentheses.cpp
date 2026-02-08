class Solution {
public:
    string reverseParentheses(string s) {
        stack<string> stk;
        string current;

        for (char c : s) {
            if (c == '(') {
                stk.push(current);
                current.clear();
            } else if (c == ')') {
                reverse(current.begin(), current.end());
                if (!stk.empty()) {
                    current = stk.top() + current;
                    stk.pop();
                }
            } else {
                current += c;
            }
        }
        return current;
    }
};