class Solution {
public:
    int findTheMatrixSum(vector<vector<int>>& mat) {
        int n = mat.size();
        int m = mat[0].size();
        vector<int> rows(n, 0), cols(m, 0);

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                rows[i] ^= mat[i][j];
                cols[j] ^= mat[i][j];
            }
        }

        int totalXor = 0;
        for (int i = 0; i < n; ++i) {
            totalXor ^= rows[i];
        }
        for (int j = 0; j < m; ++j) {
            totalXor ^= cols[j];
        }

        return totalXor;
    }
};