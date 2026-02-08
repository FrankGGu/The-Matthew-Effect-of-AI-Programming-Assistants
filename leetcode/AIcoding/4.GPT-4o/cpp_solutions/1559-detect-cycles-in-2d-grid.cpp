class Solution {
public:
    bool hasCycle(vector<vector<char>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();
        vector<vector<int>> visited(rows, vector<int>(cols, 0));

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (!visited[i][j] && dfs(grid, visited, i, j, -1, -1, grid[i][j])) {
                    return true;
                }
            }
        }
        return false;
    }

    bool dfs(vector<vector<char>>& grid, vector<vector<int>>& visited, int x, int y, int fromX, int fromY, char target) {
        if (x < 0 || x >= grid.size() || y < 0 || y >= grid[0].size() || grid[x][y] != target) {
            return false;
        }
        if (visited[x][y] == 1) {
            return true;
        }
        visited[x][y] = 1;

        for (int dir = 0; dir < 4; dir++) {
            int newX = x + dx[dir];
            int newY = y + dy[dir];
            if (newX == fromX && newY == fromY) continue;
            if (dfs(grid, visited, newX, newY, x, y, target)) {
                return true;
            }
        }
        visited[x][y] = 2;
        return false;
    }

private:
    int dx[4] = {1, -1, 0, 0};
    int dy[4] = {0, 0, 1, -1};
};