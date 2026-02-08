class Solution {
public:
    int countMatches(std::vector<std::vector<std::string>>& items, std::string ruleKey, std::string ruleValue) {
        int count = 0;
        int ruleKeyIndex;

        if (ruleKey == "type") {
            ruleKeyIndex = 0;
        } else if (ruleKey == "color") {
            ruleKeyIndex = 1;
        } else { // ruleKey == "name"
            ruleKeyIndex = 2;
        }

        for (const auto& item : items) {
            if (item[ruleKeyIndex] == ruleValue) {
                count++;
            }
        }

        return count;
    }
};