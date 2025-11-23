#include <string>
#include <vector>
#include <map>

class Solution {
public:
    std::map<std::string, int> countMentionsPerUser(std::vector<std::vector<std::string>>& mentions) {
        std::map<std::string, int> mentionCounts;

        for (const auto& mention : mentions) {
            if (mention.size() == 2) {
                std::string mentionedUser = mention[1];
                mentionCounts[mentionedUser]++;
            }
        }
        return mentionCounts;
    }
};