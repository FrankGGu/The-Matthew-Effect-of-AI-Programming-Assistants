#include <vector>
#include <string>

class Solution {
public:
    std::vector<std::vector<std::string>> partition(std::string s) {
        std::vector<std::vector<std::string>> result;
        std::vector<std::string> current_path;
        backtrack(s, 0, current_path, result);
        return result;
    }

private:
    void backtrack(const std::string& s, int start, std::vector<std::string>& current_path, std::vector<std::vector<std::string>>& result) {
        if (start == s.length()) {
            result.push_back(current_path);
            return;
        }

        for (int i = start; i < s.length(); ++i) {
            if (isPalindrome(s, start, i)) {
                current_path.push_back(s.substr(start, i - start + 1));
                backtrack(s, i + 1, current_path, result);
                current_path.pop_back();
            }
        }
    }

    bool isPalindrome(const std::string& s, int low, int high) {
        while (low < high) {
            if (s[low++] != s[high--]) {
                return false;
            }
        }
        return true;
    }
};