#include <vector>
#include <queue>
#include <utility>

class Solution {
public:
    int maxDistance(std::vector<std::vector<int>>& grid) {
        int n = grid.size();
        std::queue<std::pair<int, int>> q;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    q.push({i, j});
                }
            }
        }

        if (q.empty() || q.size() == n * n) {
            return -1;
        }

        int distance = -1;
        int dirs[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

        while (!q.empty()) {
            distance++;
            int level_size = q.size();
            for (int i = 0; i < level_size; ++i) {
                std::pair<int, int> curr = q.front();
                q.pop();

                int r = curr.first;
                int c = curr.second;

                for (auto& dir : dirs) {
                    int nr = r + dir[0];
                    int nc = c + dir[1];

                    if (nr >= 0 && nr < n && nc >= 0 && nc < n && grid[nr][nc] == 0) {
                        grid[nr][nc] = 1;
                        q.push({nr, nc});
                    }
                }
            }
        }

        return distance;
    }
};