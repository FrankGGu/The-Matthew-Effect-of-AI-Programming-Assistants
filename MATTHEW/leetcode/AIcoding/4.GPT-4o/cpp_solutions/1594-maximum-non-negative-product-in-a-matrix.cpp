class Solution {
public:
    int maxProductPath(vector<vector<int>>& grid) {
        int mod = 1e9 + 7;
        int m = grid.size(), n = grid[0].size();
        vector<vector<long long>> maxProd(m, vector<long long>(n, LONG_MIN));
        vector<vector<long long>> minProd(m, vector<long long>(n, LONG_MAX));

        maxProd[0][0] = minProd[0][0] = grid[0][0];

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i > 0) {
                    maxProd[i][j] = max(maxProd[i][j], max(maxProd[i-1][j] * grid[i][j], minProd[i-1][j] * grid[i][j]));
                    minProd[i][j] = min(minProd[i][j], min(maxProd[i-1][j] * grid[i][j], minProd[i-1][j] * grid[i][j]));
                }
                if (j > 0) {
                    maxProd[i][j] = max(maxProd[i][j], max(maxProd[i][j-1] * grid[i][j], minProd[i][j-1] * grid[i][j]));
                    minProd[i][j] = min(minProd[i][j], min(maxProd[i][j-1] * grid[i][j], minProd[i][j-1] * grid[i][j]));
                }
            }
        }

        return maxProd[m-1][n-1] < 0 ? -1 : (maxProd[m-1][n-1] % mod);
    }
};