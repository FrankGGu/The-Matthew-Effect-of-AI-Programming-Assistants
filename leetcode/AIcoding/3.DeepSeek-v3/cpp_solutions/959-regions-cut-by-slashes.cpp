class Solution {
public:
    int regionsBySlashes(vector<string>& grid) {
        int n = grid.size();
        vector<vector<int>> g(3 * n, vector<int>(3 * n, 0));
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == '/') {
                    g[3 * i][3 * j + 2] = 1;
                    g[3 * i + 1][3 * j + 1] = 1;
                    g[3 * i + 2][3 * j] = 1;
                } else if (grid[i][j] == '\\') {
                    g[3 * i][3 * j] = 1;
                    g[3 * i + 1][3 * j + 1] = 1;
                    g[3 * i + 2][3 * j + 2] = 1;
                }
            }
        }
        int res = 0;
        for (int i = 0; i < 3 * n; ++i) {
            for (int j = 0; j < 3 * n; ++j) {
                if (g[i][j] == 0) {
                    dfs(g, i, j);
                    ++res;
                }
            }
        }
        return res;
    }

    void dfs(vector<vector<int>>& g, int i, int j) {
        if (i < 0 || j < 0 || i >= g.size() || j >= g.size() || g[i][j] == 1) return;
        g[i][j] = 1;
        dfs(g, i - 1, j);
        dfs(g, i + 1, j);
        dfs(g, i, j - 1);
        dfs(g, i, j + 1);
    }
};