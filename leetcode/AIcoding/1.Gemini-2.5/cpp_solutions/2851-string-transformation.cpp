#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    bool rotateString(std::string s, std::string goal) {
        if (s.length() != goal.length()) {
            return false;
        }
        if (s.empty()) {
            return true;
        }
        std::string temp = s + s;
        return temp.find(goal) != std::string::npos;
    }
};