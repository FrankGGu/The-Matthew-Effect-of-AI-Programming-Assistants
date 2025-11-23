class Solution {
public:
    string removeOuterParentheses(string S) {
        int balance = 0;
        string result;
        for (char c : S) {
            if (c == '(') {
                if (balance++ > 0) result += c;
            } else {
                if (--balance > 0) result += c;
            }
        }
        return result;
    }
};