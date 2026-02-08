class Solution {
public:
    int longestValidParentheses(string s) {
        int maxLength = 0;
        stack<int> stk;
        stk.push(-1);

        for (int i = 0; i < s.size(); i++) {
            if (s[i] == '(') {
                stk.push(i);
            } else {
                stk.pop();
                if (stk.empty()) {
                    stk.push(i);
                } else {
                    maxLength = max(maxLength, i - stk.top());
                }
            }
        }

        return maxLength;
    }
};