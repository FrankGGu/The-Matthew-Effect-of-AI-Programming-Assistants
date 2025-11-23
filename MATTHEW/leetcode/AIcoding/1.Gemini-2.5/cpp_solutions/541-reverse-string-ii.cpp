#include <string>
#include <algorithm>

class Solution {
public:
    std::string reverseStr(std::string s, int k) {
        for (int i = 0; i < s.length(); i += 2 * k) {
            int start = i;
            int end = std::min(i + k, (int)s.length());
            std::reverse(s.begin() + start, s.begin() + end);
        }
        return s;
    }
};