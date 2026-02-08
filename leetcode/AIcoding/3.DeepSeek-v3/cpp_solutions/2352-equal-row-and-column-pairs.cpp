class Solution {
public:
    int equalPairs(vector<vector<int>>& grid) {
        int n = grid.size();
        map<vector<int>, int> rowCount;
        for (const auto& row : grid) {
            rowCount[row]++;
        }

        int res = 0;
        for (int j = 0; j < n; ++j) {
            vector<int> col;
            for (int i = 0; i < n; ++i) {
                col.push_back(grid[i][j]);
            }
            if (rowCount.find(col) != rowCount.end()) {
                res += rowCount[col];
            }
        }
        return res;
    }
};