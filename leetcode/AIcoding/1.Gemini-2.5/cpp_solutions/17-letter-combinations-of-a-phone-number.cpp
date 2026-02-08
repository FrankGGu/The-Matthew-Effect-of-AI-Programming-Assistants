#include <vector>
#include <string>

class Solution {
public:
    std::vector<std::string> letterCombinations(std::string digits) {
        std::vector<std::string> result;
        if (digits.empty()) {
            return result;
        }

        const std::vector<std::string> mapping = {
            "", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"
        };

        std::string currentCombination;
        backtrack(digits, 0, currentCombination, mapping, result);

        return result;
    }

private:
    void backtrack(const std::string& digits, int index, std::string& currentCombination, const std::vector<std::string>& mapping, std::vector<std::string>& result) {
        if (index == digits.length()) {
            result.push_back(currentCombination);
            return;
        }

        std::string letters = mapping[digits[index] - '0'];
        for (char letter : letters) {
            currentCombination.push_back(letter);
            backtrack(digits, index + 1, currentCombination, mapping, result);
            currentCombination.pop_back();
        }
    }
};