#include <string>
#include <algorithm>

class Solution {
public:
    int expandAroundCenter(const std::string& s, int left, int right) {
        int L = left;
        int R = right;
        while (L >= 0 && R < s.length() && s[L] == s[R]) {
            L--;
            R++;
        }
        return R - L - 1;
    }

    std::string longestPalindrome(std::string s) {
        if (s.length() < 1) {
            return "";
        }

        int start = 0;
        int maxLength = 0;

        for (int i = 0; i < s.length(); ++i) {
            int len1 = expandAroundCenter(s, i, i);
            int len2 = expandAroundCenter(s, i, i + 1);

            int currentLen = std::max(len1, len2);

            if (currentLen > maxLength) {
                maxLength = currentLen;
                start = i - (currentLen - 1) / 2;
            }
        }

        return s.substr(start, maxLength);
    }
};