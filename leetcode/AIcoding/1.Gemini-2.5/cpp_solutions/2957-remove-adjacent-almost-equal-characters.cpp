#include <string>
#include <cmath> // Required for std::abs

class Solution {
public:
    int removeAlmostEqualCharacters(std::string word) {
        std::string res = "";
        for (char c : word) {
            if (!res.empty() && std::abs(res.back() - c) <= 1) {
                res.pop_back();
            } else {
                res.push_back(c);
            }
        }
        return res.length();
    }
};