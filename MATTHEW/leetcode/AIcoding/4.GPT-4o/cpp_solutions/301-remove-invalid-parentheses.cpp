class Solution {
public:
    vector<string> removeInvalidParentheses(string s) {
        unordered_set<string> result;
        int left = 0, right = 0;
        for (char c : s) {
            if (c == '(') left++;
            if (c == ')') {
                if (left == 0) right++;
                else left--;
            }
        }
        dfs(s, 0, left, right, 0, "", result);
        return vector<string>(result.begin(), result.end());
    }

    void dfs(string s, int index, int left, int right, int balance, string current, unordered_set<string>& result) {
        if (index == s.size()) {
            if (left == 0 && right == 0 && balance == 0) {
                result.insert(current);
            }
            return;
        }

        char c = s[index];
        if (c == '(') {
            dfs(s, index + 1, left, right, balance, current + c, result); // keep (
            if (left > 0) dfs(s, index + 1, left - 1, right, balance, current, result); // remove (
        } else if (c == ')') {
            dfs(s, index + 1, left, right, balance, current + c, result); // keep )
            if (right > 0 && balance == 0) dfs(s, index + 1, left, right - 1, balance, current, result); // remove )
        } else {
            dfs(s, index + 1, left, right, balance, current + c, result); // keep non-parenthesis
        }
    }
};