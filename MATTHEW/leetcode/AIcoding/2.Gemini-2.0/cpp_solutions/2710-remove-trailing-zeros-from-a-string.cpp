#include <string>

class Solution {
public:
    std::string removeTrailingZeros(std::string s) {
        int n = s.length();
        int i = n - 1;
        while (i >= 0 && s[i] == '0') {
            i--;
        }
        return s.substr(0, i + 1);
    }
};