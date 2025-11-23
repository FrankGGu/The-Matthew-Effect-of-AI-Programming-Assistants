class Solution {
public:
    int minFallingPathSum(vector<vector<int>>& matrix) {
        int n = matrix.size();
        for (int i = n - 2; i >= 0; --i) {
            for (int j = 0; j < n; ++j) {
                int minBelow = matrix[i + 1][j];
                if (j > 0) minBelow = min(minBelow, matrix[i + 1][j - 1]);
                if (j < n - 1) minBelow = min(minBelow, matrix[i + 1][j + 1]);
                matrix[i][j] += minBelow;
            }
        }
        return *min_element(matrix[0].begin(), matrix[0].end());
    }
};