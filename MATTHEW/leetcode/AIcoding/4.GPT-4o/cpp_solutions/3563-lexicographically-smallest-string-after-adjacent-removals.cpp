class Solution {
public:
    string smallestString(string s) {
        stack<char> stk;
        for (char c : s) {
            while (!stk.empty() && stk.top() > c) {
                stk.pop();
            }
            stk.push(c);
        }
        string result;
        while (!stk.empty()) {
            result += stk.top();
            stk.pop();
        }
        reverse(result.begin(), result.end());
        return result;
    }
};