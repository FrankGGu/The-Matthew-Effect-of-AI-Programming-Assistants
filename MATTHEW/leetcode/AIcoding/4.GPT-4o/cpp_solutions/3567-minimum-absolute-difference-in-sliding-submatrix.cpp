class Solution {
public:
    int minimumAbsDifference(vector<vector<int>>& matrix) {
        int n = matrix.size(), m = matrix[0].size();
        int minDiff = INT_MAX;

        for (int i = 0; i < n - 1; ++i) {
            for (int j = 0; j < m - 1; ++j) {
                int a = matrix[i][j];
                int b = matrix[i][j + 1];
                int c = matrix[i + 1][j];
                int d = matrix[i + 1][j + 1];

                minDiff = min(minDiff, min({abs(a - b), abs(a - c), abs(a - d), abs(b - c), abs(b - d), abs(c - d)}));
            }
        }
        return minDiff;
    }
};