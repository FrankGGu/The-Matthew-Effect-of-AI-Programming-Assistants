class Solution {
public:
    vector<vector<string>> removeDuplicateRows(vector<vector<string>>& rows) {
        set<vector<string>> uniqueRows(rows.begin(), rows.end());
        return vector<vector<string>>(uniqueRows.begin(), uniqueRows.end());
    }
};