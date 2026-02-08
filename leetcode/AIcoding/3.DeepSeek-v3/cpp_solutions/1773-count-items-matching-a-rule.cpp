class Solution {
public:
    int countMatches(vector<vector<string>>& items, string ruleKey, string ruleValue) {
        int count = 0;
        int index;
        if (ruleKey == "type") {
            index = 0;
        } else if (ruleKey == "color") {
            index = 1;
        } else if (ruleKey == "name") {
            index = 2;
        }
        for (const auto& item : items) {
            if (item[index] == ruleValue) {
                count++;
            }
        }
        return count;
    }
};