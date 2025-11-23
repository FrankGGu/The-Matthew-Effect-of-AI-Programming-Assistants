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

        if (isalpha(s[index])) {
            s[index] = tolower(s[index]);
            backtrack(s, index + 1, result);
            s[index] = toupper(s[index]);
            backtrack(s, index + 1, result);
        } else {
            backtrack(s, index + 1, result);
        }
    }
};