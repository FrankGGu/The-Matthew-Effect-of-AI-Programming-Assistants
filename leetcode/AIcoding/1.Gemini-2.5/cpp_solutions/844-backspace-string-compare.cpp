#include <string>
#include <vector>

class Solution {
public:
    std::string buildString(const std::string& str) {
        std::string built;
        for (char c : str) {
            if (c == '#') {
                if (!built.empty()) {
                    built.pop_back();
                }
            } else {
                built.push_back(c);
            }
        }
        return built;
    }

    bool backspaceCompare(std::string s, std::string t) {
        return buildString(s) == buildString(t);
    }
};