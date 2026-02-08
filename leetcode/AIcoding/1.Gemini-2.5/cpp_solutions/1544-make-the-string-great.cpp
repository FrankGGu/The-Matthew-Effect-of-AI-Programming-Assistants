#include <string>
#include <vector>
#include <cmath>

class Solution {
public:
    std::string makeGood(std::string s) {
        std::string result = "";
        for (char c : s) {
            if (!result.empty() && std::abs(result.back() - c) == 32) {
                result.pop_back();
            } else {
                result.push_back(c);
            }
        }
        return result;
    }
};