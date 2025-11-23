#include <string>
#include <vector>

class Solution {
public:
    bool isPrefixString(std::string s, std::vector<std::string>& words) {
        std::string prefix = "";
        for (const std::string& word : words) {
            prefix += word;
            if (prefix == s) {
                return true;
            } else if (prefix.length() > s.length()) {
                return false;
            }
        }
        return false;
    }
};