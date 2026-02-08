#include <vector>
#include <string>

class Solution {
public:
    int longestCommonPrefix(std::vector<std::string>& strs) {
        if (strs.empty()) {
            return 0;
        }

        std::string prefix = strs[0];

        for (size_t i = 1; i < strs.size(); ++i) {
            while (strs[i].find(prefix) != 0) {
                prefix = prefix.substr(0, prefix.length() - 1);
                if (prefix.empty()) {
                    return 0;
                }
            }
        }

        return prefix.length();
    }
};