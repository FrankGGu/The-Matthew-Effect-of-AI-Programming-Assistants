#include <string>
#include <vector>

class Solution {
public:
    std::string removeStars(std::string s) {
        std::string result = "";
        for (char c : s) {
            if (c == '*') {
                if (!result.empty()) {
                    result.pop_back();
                }
            } else {
                result.push_back(c);
            }
        }
        return result;
    }
};