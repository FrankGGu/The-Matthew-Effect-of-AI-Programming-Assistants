#include <vector>
#include <string>
#include <numeric>

class Solution {
public:
    std::vector<std::vector<std::string>> partition(std::string s) {
        std::vector<std::vector<std::string>> result;
        std::vector<std::string> currentPartition;
        backtrack(s, 0, currentPartition, result);
        return result;
    }

private:
    void backtrack(const std::string& s, int startIndex, std::vector<std::string>& currentPartition, std::vector<std::vector<std::string>>& result) {
        if (startIndex == s.length()) {
            result.push_back(currentPartition);
            return;
        }

        for (int i = startIndex; i < s.length(); ++i) {
            if (isPalindrome(s, startIndex, i)) {
                currentPartition.push_back(s.substr(startIndex, i - startIndex + 1));
                backtrack(s, i + 1, currentPartition, result);
                currentPartition.pop_back();
            }
        }
    }

    bool isPalindrome(const std::string& s, int low, int high) {
        while (low < high) {
            if (s[low] != s[high]) {
                return false;
            }
            low++;
            high--;
        }
        return true;
    }
};