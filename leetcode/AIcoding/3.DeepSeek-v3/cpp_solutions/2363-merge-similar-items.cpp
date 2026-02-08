class Solution {
public:
    vector<vector<int>> mergeSimilarItems(vector<vector<int>>& items1, vector<vector<int>>& items2) {
        map<int, int> weightMap;
        for (const auto& item : items1) {
            weightMap[item[0]] += item[1];
        }
        for (const auto& item : items2) {
            weightMap[item[0]] += item[1];
        }
        vector<vector<int>> result;
        for (const auto& entry : weightMap) {
            result.push_back({entry.first, entry.second});
        }
        return result;
    }
};