class Solution {
public:
    vector<int> getOrder(vector<vector<int>>& items, int n) {
        vector<pair<int, int>> itemPairs;
        for (auto& item : items) {
            itemPairs.emplace_back(item[0], item[1]);
        }
        sort(itemPairs.begin(), itemPairs.end(), [](const auto& a, const auto& b) {
            return a.first < b.first || (a.first == b.first && a.second > b.second);
        });
        vector<int> result;
        for (auto& item : itemPairs) {
            result.push_back(item.first);
        }
        return result;
    }
};