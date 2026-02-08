#include <string>

class Solution {
public:
    bool repeatedSubstringPattern(std::string s) {
        int n = s.length();
        std::string temp = s + s;
        temp = temp.substr(1, 2 * n - 2);
        return temp.find(s) != std::string::npos;
    }
};