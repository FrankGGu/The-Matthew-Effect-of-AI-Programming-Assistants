#include <vector>
#include <string>

class Solution {
public:
    std::vector<std::string> getLongestSubsequence(std::vector<std::string>& groups, std::vector<std::string>& words) {
        std::vector<std::string> result;
        if (groups.empty()) {
            return result;
        }

        result.push_back(words[0]);
        std::string last_group = groups[0];

        for (int i = 1; i < groups.size(); ++i) {
            if (groups[i] != last_group) {
                result.push_back(words[i]);
                last_group = groups[i];
            }
        }

        return result;
    }
};