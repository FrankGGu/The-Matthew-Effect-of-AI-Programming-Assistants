#include <algorithm>
#include <string>

class Solution {
public:
    int minimumSum(int num) {
        std::string s = std::to_string(num);
        std::sort(s.begin(), s.end());
        return (s[0] - '0' + s[1] - '0') * 10 + (s[2] - '0' + s[3] - '0');
    }
};