#include <string>
#include <vector>

class Solution {
public:
    bool isPrefixString(std::string s, std::vector<std::string>& words) {
        std::string current_prefix = "";
        for (const std::string& word : words) {
            current_prefix += word;
            if (current_prefix == s) {
                return true;
            }
            if (current_prefix.length() >= s.length()) {
                return false;
            }
        }
        return false;
    }
};