class Solution {
public:
    vector<vector<int>> constructProductMatrix(vector<vector<int>>& grid) {
        int n = grid.size();
        if (n == 0) return {};
        int m = grid[0].size();
        vector<vector<int>> res(n, vector<int>(m, 1));
        long long prefix = 1;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                res[i][j] = prefix;
                prefix = (prefix * grid[i][j]) % 12345;
            }
        }
        long long suffix = 1;
        for (int i = n - 1; i >= 0; --i) {
            for (int j = m - 1; j >= 0; --j) {
                res[i][j] = (res[i][j] * suffix) % 12345;
                suffix = (suffix * grid[i][j]) % 12345;
            }
        }
        return res;
    }
};