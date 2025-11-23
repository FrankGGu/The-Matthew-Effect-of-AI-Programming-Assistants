class Solution {
public:
    vector<string> letterCombinations(string digits) {
        if (digits.empty()) return {};

        vector<string> phone = {"", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"};
        vector<string> result;
        result.push_back("");

        for (char digit : digits) {
            vector<string> temp;
            string letters = phone[digit - '0'];
            for (string s : result) {
                for (char letter : letters) {
                    temp.push_back(s + letter);
                }
            }
            result = temp;
        }

        return result;
    }
};