class Solution {
public:
    vector<vector<string>> recommendedPairs(vector<string>& items, vector<vector<string>>& categories) {
        unordered_map<string, unordered_set<string>> categoryMap;
        for (const auto& category : categories) {
            for (size_t i = 1; i < category.size(); ++i) {
                categoryMap[category[i]].insert(category[0]);
            }
        }

        vector<vector<string>> result;
        unordered_set<string> uniqueItems(items.begin(), items.end());

        for (const auto& item : uniqueItems) {
            for (const auto& category : categoryMap[item]) {
                for (const auto& otherItem : uniqueItems) {
                    if (otherItem != item && categoryMap[otherItem].count(category)) {
                        result.push_back({item, otherItem});
                    }
                }
            }
        }

        return result;
    }
};