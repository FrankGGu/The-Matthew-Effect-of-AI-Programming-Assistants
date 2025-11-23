#include <vector>

using namespace std;

class Solution {
public:
    int getMaximumGold(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        int maxGold = 0;

        function<void(int, int, int, vector<vector<bool>>&)> dfs = 
            [&](int row, int col, int currentGold, vector<vector<bool>>& visited) {
            if (row < 0 || row >= m || col < 0 || col >= n || grid[row][col] == 0 || visited[row][col]) {
                maxGold = max(maxGold, currentGold);
                return;
            }

            visited[row][col] = true;
            int gold = grid[row][col];

            dfs(row + 1, col, currentGold + gold, visited);
            dfs(row - 1, col, currentGold + gold, visited);
            dfs(row, col + 1, currentGold + gold, visited);
            dfs(row, col - 1, currentGold + gold, visited);

            visited[row][col] = false;
        };

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] != 0) {
                    vector<vector<bool>> visited(m, vector<bool>(n, false));
                    dfs(i, j, 0, visited);
                }
            }
        }

        return maxGold;
    }
};