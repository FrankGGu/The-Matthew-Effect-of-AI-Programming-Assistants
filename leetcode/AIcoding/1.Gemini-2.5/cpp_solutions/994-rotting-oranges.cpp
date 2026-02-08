#include <vector>
#include <queue>

class Solution {
public:
    int orangesRotting(std::vector<std::vector<int>>& grid) {
        int R = grid.size();
        if (R == 0) return 0;
        int C = grid[0].size();
        if (C == 0) return 0;

        std::queue<std::pair<int, int>> q;
        int freshOranges = 0;

        for (int r = 0; r < R; ++r) {
            for (int c = 0; c < C; ++c) {
                if (grid[r][c] == 1) {
                    freshOranges++;
                } else if (grid[r][c] == 2) {
                    q.push({r, c});
                }
            }
        }

        if (freshOranges == 0) {
            return 0;
        }

        int minutes = 0;
        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        while (!q.empty() && freshOranges > 0) {
            int levelSize = q.size();
            for (int i = 0; i < levelSize; ++i) {
                std::pair<int, int> curr = q.front();
                q.pop();
                int r = curr.first;
                int c = curr.second;

                for (int d = 0; d < 4; ++d) {
                    int nr = r + dr[d];
                    int nc = c + dc[d];

                    if (nr >= 0 && nr < R && nc >= 0 && nc < C && grid[nr][nc] == 1) {
                        grid[nr][nc] = 2; // Mark as rotten
                        freshOranges--;
                        q.push({nr, nc});
                    }
                }
            }
            minutes++;
        }

        if (freshOranges > 0) {
            return -1;
        } else {
            return minutes;
        }
    }
};