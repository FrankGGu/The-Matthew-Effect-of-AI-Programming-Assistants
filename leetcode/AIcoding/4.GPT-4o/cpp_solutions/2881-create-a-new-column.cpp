class Solution {
public:
    vector<vector<string>> createNewColumn(vector<vector<string>>& data) {
        vector<vector<string>> result;
        for (const auto& row : data) {
            vector<string> newRow = row;
            newRow.push_back(row[0] + row[1]);
            result.push_back(newRow);
        }
        return result;
    }
};