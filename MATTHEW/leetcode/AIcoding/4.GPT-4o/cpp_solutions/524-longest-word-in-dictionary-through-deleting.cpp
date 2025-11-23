#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    std::string findLongestWord(std::string s, std::vector<std::string>& dictionary) {
        std::string result = "";
        for (const auto& word : dictionary) {
            if (isSubsequence(s, word)) {
                if (word.length() > result.length() || (word.length() == result.length() && word < result)) {
                    result = word;
                }
            }
        }
        return result;
    }

private:
    bool isSubsequence(const std::string& s, const std::string& word) {
        int j = 0;
        for (char c : s) {
            if (j < word.length() && c == word[j]) {
                j++;
            }
        }
        return j == word.length();
    }
};