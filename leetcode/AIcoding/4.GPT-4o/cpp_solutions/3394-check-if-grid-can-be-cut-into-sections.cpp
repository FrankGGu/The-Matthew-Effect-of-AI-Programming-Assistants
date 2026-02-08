class Solution {
public:
    bool canCutGrid(vector<vector<int>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();
        vector<vector<int>> visited(rows, vector<int>(cols, 0));

        function<void(int, int, int)> dfs = [&](int r, int c, int color) {
            if (r < 0 || r >= rows || c < 0 || c >= cols || visited[r][c] || grid[r][c] != color) return;
            visited[r][c] = 1;
            dfs(r + 1, c, color);
            dfs(r - 1, c, color);
            dfs(r, c + 1, color);
            dfs(r, c - 1, color);
        };

        for (int r = 0; r < rows; ++r) {
            for (int c = 0; c < cols; ++c) {
                if (!visited[r][c]) {
                    int color = grid[r][c];
                    dfs(r, c, color);
                    if (color != grid[r][c]) return false;
                }
            }
        }

        return true;
    }
};