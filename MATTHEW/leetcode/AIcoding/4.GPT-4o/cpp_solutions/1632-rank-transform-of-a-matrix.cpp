class Solution {
public:
    vector<vector<int>> matrixRankTransform(vector<vector<int>>& matrix) {
        int m = matrix.size(), n = matrix[0].size();
        vector<int> ranks(m + n, 0);
        vector<tuple<int, int, int>> cells;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                cells.emplace_back(matrix[i][j], i, j);
            }
        }

        sort(cells.begin(), cells.end());

        vector<int> row(m), col(n);
        for (auto &[value, i, j] : cells) {
            int r = 1 + max(row[i], col[j]);
            row[i] = r;
            col[j] = r;
            ranks[i] = max(ranks[i], r);
        }

        vector<vector<int>> result(m, vector<int>(n));
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                result[i][j] = ranks[i];
            }
        }

        return result;
    }
};