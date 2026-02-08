#include <string>

class Solution {
public:
    std::string makeFancyString(std::string s) {
        std::string result = "";
        for (char c : s) {
            if (result.length() < 2) {
                result.push_back(c);
            } else {
                if (!(c == result.back() && c == result[result.length() - 2])) {
                    result.push_back(c);
                }
            }
        }
        return result;
    }
};