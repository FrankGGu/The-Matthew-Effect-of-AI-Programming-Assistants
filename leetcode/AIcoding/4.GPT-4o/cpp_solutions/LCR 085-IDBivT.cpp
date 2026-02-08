class Solution {
public:
    vector<string> generateParenthesis(int n) {
        vector<string> result;
        backtrack(result, "", n, n);
        return result;
    }

    void backtrack(vector<string>& result, string current, int left, int right) {
        if (left == 0 && right == 0) {
            result.push_back(current);
            return;
        }
        if (left > 0) {
            backtrack(result, current + "(", left - 1, right);
        }
        if (right > left) {
            backtrack(result, current + ")", left, right - 1);
        }
    }
};