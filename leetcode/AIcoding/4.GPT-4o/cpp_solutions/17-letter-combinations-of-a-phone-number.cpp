class Solution {
public:
    vector<string> letterCombinations(string digits) {
        vector<string> result;
        if (digits.empty()) return result;
        vector<string> mapping = {"", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"};
        string combination;
        backtrack(result, mapping, combination, digits, 0);
        return result;
    }

    void backtrack(vector<string>& result, vector<string>& mapping, string& combination, const string& digits, int index) {
        if (index == digits.size()) {
            result.push_back(combination);
            return;
        }
        for (char letter : mapping[digits[index] - '0']) {
            combination.push_back(letter);
            backtrack(result, mapping, combination, digits, index + 1);
            combination.pop_back();
        }
    }
};