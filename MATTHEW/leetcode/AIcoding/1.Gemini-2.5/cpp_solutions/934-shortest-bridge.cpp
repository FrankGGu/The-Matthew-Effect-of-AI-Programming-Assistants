#include <vector>
#include <queue>
#include <utility>

class Solution {
private:
    int n;
    int dx[4] = {0, 0, 1, -1};
    int dy[4] = {1, -1, 0, 0};

    void dfs(int r, int c, std::vector<std::vector<int>>& grid, std::queue<std::pair<int, int>>& q) {
        if (r < 0 || r >= n || c < 0 || c >= n || grid[r][c] != 1) {
            return;
        }
        grid[r][c] = 2; 
        q.push({r, c});

        for (int i = 0; i < 4; ++i) {
            dfs(r + dx[i], c + dy[i], grid, q);
        }
    }

public:
    int shortestBridge(std::vector<std::vector<int>>& grid) {
        n = grid.size();
        std::queue<std::pair<int, int>> q;
        bool foundFirstIsland = false;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1 && !foundFirstIsland) {
                    dfs(i, j, grid, q);
                    foundFirstIsland = true;
                    break; 
                }
            }
            if (foundFirstIsland) {
                break;
            }
        }

        int distance = 0;
        while (!q.empty()) {
            int levelSize = q.size();
            for (int k = 0; k < levelSize; ++k) {
                std::pair<int, int> curr = q.front();
                q.pop();
                int r = curr.first;
                int c = curr.second;

                for (int i = 0; i < 4; ++i) {
                    int nr = r + dx[i];
                    int nc = c + dy[i];

                    if (nr >= 0 && nr < n && nc >= 0 && nc < n) {
                        if (grid[nr][nc] == 1) {
                            return distance;
                        }
                        if (grid[nr][nc] == 0) {
                            grid[nr][nc] = 2; 
                            q.push({nr, nc});
                        }
                    }
                }
            }
            distance++;
        }
        return -1; 
    }
};