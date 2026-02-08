class Solution {
public:
    string minRemoveToMakeValid(string s) {
        int open = 0;
        for (char c : s) {
            if (c == '(') open++;
            else if (c == ')') open = open > 0 ? open - 1 : 0;
        }

        string result;
        int toRemove = open;
        for (char c : s) {
            if (c == '(') {
                if (toRemove > 0) {
                    toRemove--;
                } else {
                    result += c;
                }
            } else if (c == ')') {
                if (open > 0) {
                    result += c;
                    open--;
                }
            } else {
                result += c;
            }
        }
        return result;
    }
};