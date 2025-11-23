#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> letterCombinations(string digits) {
        vector<string> result;
        if (digits.empty()) return result;

        vector<string> mapping = {"", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"};
        string combination = "";
        backtrack(digits, 0, mapping, combination, result);

        return result;
    }

private:
    void backtrack(string digits, int index, vector<string>& mapping, string& combination, vector<string>& result) {
        if (index == digits.length()) {
            result.push_back(combination);
            return;
        }

        int digit = digits[index] - '0';
        string letters = mapping[digit];

        for (char letter : letters) {
            combination.push_back(letter);
            backtrack(digits, index + 1, mapping, combination, result);
            combination.pop_back();
        }
    }
};