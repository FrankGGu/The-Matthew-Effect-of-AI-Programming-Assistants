class Solution {
public:
    vector<string> letterCasePermutation(string s) {
        vector<string> result;
        backtrack(s, 0, result);
        return result;
    }

    void backtrack(string &s, int index, vector<string> &result) {
        if (index == s.size()) {
            result.push_back(s);
            return;
        }

        backtrack(s, index + 1, result);
        if (isalpha(s[index])) {
            s[index] ^= 32; // toggle case
            backtrack(s, index + 1, result);
            s[index] ^= 32; // revert back
        }
    }
};