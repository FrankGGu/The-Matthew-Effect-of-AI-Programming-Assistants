class Solution {
public:
    vector<int> luckyNumbers (vector<vector<int>>& matrix) {
        vector<int> res;
        int m = matrix.size();
        if (m == 0) return res;
        int n = matrix[0].size();

        vector<int> rowMin(m, INT_MAX);
        vector<int> colMax(n, INT_MIN);

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                rowMin[i] = min(rowMin[i], matrix[i][j]);
                colMax[j] = max(colMax[j], matrix[i][j]);
            }
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (matrix[i][j] == rowMin[i] && matrix[i][j] == colMax[j]) {
                    res.push_back(matrix[i][j]);
                }
            }
        }

        return res;
    }
};