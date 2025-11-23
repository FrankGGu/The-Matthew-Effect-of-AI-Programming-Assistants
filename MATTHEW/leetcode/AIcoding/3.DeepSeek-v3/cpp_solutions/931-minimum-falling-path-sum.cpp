class Solution {
public:
    int minFallingPathSum(vector<vector<int>>& matrix) {
        int n = matrix.size();
        if (n == 1) return matrix[0][0];

        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                int min_val = matrix[i-1][j];
                if (j > 0) min_val = min(min_val, matrix[i-1][j-1]);
                if (j < n-1) min_val = min(min_val, matrix[i-1][j+1]);
                matrix[i][j] += min_val;
            }
        }

        return *min_element(matrix[n-1].begin(), matrix[n-1].end());
    }
};