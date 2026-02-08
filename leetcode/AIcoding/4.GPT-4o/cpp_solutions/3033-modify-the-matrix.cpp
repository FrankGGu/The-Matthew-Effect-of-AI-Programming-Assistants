class Solution {
public:
    void modifyMatrix(vector<vector<int>>& matrix) {
        int m = matrix.size(), n = matrix[0].size();
        vector<vector<bool>> zeroRows(m, vector<bool>(n, false));
        vector<vector<bool>> zeroCols(m, vector<bool>(n, false));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (matrix[i][j] == 0) {
                    zeroRows[i][j] = true;
                    zeroCols[i][j] = true;
                }
            }
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (zeroRows[i][j] || zeroCols[i][j]) {
                    matrix[i][j] = 0;
                }
            }
        }
    }
};