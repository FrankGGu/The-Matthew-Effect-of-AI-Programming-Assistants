#include <string>
#include <vector>

class Solution {
public:
    std::string longestCommonPrefix(std::vector<std::string>& strs) {
        if (strs.empty()) {
            return "";
        }

        std::string prefix = strs[0];

        for (size_t i = 1; i < strs.size(); ++i) {
            while (strs[i].find(prefix) != 0) {
                prefix.pop_back();
                if (prefix.empty()) {
                    return "";
                }
            }
        }

        return prefix;
    }
};