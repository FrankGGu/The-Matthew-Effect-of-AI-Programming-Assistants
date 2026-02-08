class Solution {
public:
    int countSubmatrices(vector<vector<int>>& grid, int k) {
        int m = grid.size();
        if (m == 0) return 0;
        int n = grid[0].size();
        vector<vector<int>> prefix(m, vector<int>(n, 0));
        int res = 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                prefix[i][j] = grid[i][j];
                if (i > 0) prefix[i][j] += prefix[i-1][j];
                if (j > 0) prefix[i][j] += prefix[i][j-1];
                if (i > 0 && j > 0) prefix[i][j] -= prefix[i-1][j-1];
                if (prefix[i][j] <= k) res++;
            }
        }

        return res;
    }
};