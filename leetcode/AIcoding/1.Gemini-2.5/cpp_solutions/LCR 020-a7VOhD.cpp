#include <string>

class Solution {
public:
    int countSubstrings(std::string s) {
        int n = s.length();
        if (n == 0) {
            return 0;
        }

        int totalCount = 0;

        for (int i = 0; i < n; ++i) {
            // Odd length palindromes, center is s[i]
            expandAndCount(s, i, i, totalCount);

            // Even length palindromes, center is s[i] and s[i+1]
            expandAndCount(s, i, i + 1, totalCount);
        }
        return totalCount;
    }

private:
    void expandAndCount(const std::string& s, int left, int right, int& totalCount) {
        while (left >= 0 && right < s.length() && s[left] == s[right]) {
            totalCount++;
            left--;
            right++;
        }
    }
};