class Solution {
public:
    vector<vector<int>> dropMissingData(vector<vector<int>>& data) {
        vector<vector<int>> result;
        for (const auto& row : data) {
            if (find(row.begin(), row.end(), -1) == row.end()) {
                result.push_back(row);
            }
        }
        return result;
    }
};