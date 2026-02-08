class Solution {
public:
    int matrixScore(vector<vector<int>>& A) {
        int m = A.size(), n = A[0].size();
        int result = (1 << (n - 1)) * m;

        for (int j = 1; j < n; ++j) {
            int ones = 0;
            for (int i = 0; i < m; ++i) {
                ones += A[i][j] == A[i][0] ? 1 : 0;
            }
            result += max(ones, m - ones) * (1 << (n - 1 - j));
        }

        return result;
    }
};