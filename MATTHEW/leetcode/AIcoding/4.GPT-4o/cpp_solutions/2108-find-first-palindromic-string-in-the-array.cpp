#include <vector>
#include <string>

class Solution {
public:
    std::string firstPalindrome(std::vector<std::string>& words) {
        for (const auto& word : words) {
            if (isPalindrome(word)) {
                return word;
            }
        }
        return "";
    }

private:
    bool isPalindrome(const std::string& s) {
        int left = 0, right = s.size() - 1;
        while (left < right) {
            if (s[left] != s[right]) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }
};