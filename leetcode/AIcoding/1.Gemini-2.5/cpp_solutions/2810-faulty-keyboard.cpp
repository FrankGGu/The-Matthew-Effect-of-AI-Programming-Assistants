#include <string>
#include <algorithm>

class Solution {
public:
    std::string finalString(std::string s) {
        std::string result = "";
        for (char c : s) {
            if (c == 'i') {
                std::reverse(result.begin(), result.end());
            } else {
                result.push_back(c);
            }
        }
        return result;
    }
};