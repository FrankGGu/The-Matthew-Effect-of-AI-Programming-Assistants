#include <string>
#include <algorithm>

class Solution {
public:
    std::string makeSmallestPalindrome(std::string s) {
        int i = 0;
        int j = s.length() - 1;
        while (i < j) {
            if (s[i] != s[j]) {
                s[i] = s[j] = std::min(s[i], s[j]);
            }
            i++;
            j--;
        }
        return s;
    }
};