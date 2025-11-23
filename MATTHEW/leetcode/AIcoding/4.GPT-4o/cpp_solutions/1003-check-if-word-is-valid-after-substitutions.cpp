class Solution {
public:
    bool isValid(string s) {
        stack<char> stk;
        for (char c : s) {
            if (c == 'c') {
                if (stk.size() < 2 || stk.top() != 'b') return false;
                stk.pop();
                if (stk.top() != 'a') return false;
                stk.pop();
            } else {
                stk.push(c);
            }
        }
        return stk.empty();
    }
};