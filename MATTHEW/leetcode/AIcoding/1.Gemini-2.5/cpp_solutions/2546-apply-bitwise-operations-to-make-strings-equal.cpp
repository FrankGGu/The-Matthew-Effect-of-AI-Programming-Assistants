#include <string>
#include <vector>

class Solution {
public:
    bool makeStringsEqual(std::string s, std::string t) {
        bool s_has_one = (s.find('1') != std::string::npos);
        bool t_has_one = (t.find('1') != std::string::npos);
        return s_has_one == t_has_one;
    }
};