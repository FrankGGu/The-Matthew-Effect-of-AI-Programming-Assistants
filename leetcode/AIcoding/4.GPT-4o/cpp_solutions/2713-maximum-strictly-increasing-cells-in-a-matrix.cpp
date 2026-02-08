class Solution {
public:
    int maxIncreasingCells(vector<vector<int>>& mat) {
        int n = mat.size(), m = mat[0].size();
        vector<int> row(n, 0), col(m, 0);
        vector<pair<int, pair<int, int>>> cells;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                cells.push_back({mat[i][j], {i, j}});
            }
        }

        sort(cells.begin(), cells.end());

        for (auto& cell : cells) {
            int x = cell.second.first, y = cell.second.second;
            row[x] = max(row[x], col[y] + 1);
            col[y] = max(col[y], row[x] + 1);
        }

        return max(*max_element(row.begin(), row.end()), *max_element(col.begin(), col.end()));
    }
};