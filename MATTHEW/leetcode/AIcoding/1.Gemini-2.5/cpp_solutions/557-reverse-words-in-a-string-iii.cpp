#include <string>
#include <algorithm>

class Solution {
public:
    std::string reverseWords(std::string s) {
        int n = s.length();
        int start = 0;

        for (int i = 0; i <= n; ++i) {
            if (i == n || s[i] == ' ') {
                std::reverse(s.begin() + start, s.begin() + i);
                start = i + 1;
            }
        }
        return s;
    }
};