#include <vector>

class Solution {
public:
    bool dfs(int r, int c, std::vector<std::vector<int>>& grid, int R, int C) {
        if (r < 0 || r >= R || c < 0 || c >= C) {
            return false;
        }

        if (grid[r][c] == 1) {
            return true;
        }

        grid[r][c] = 1;

        bool is_closed = true;
        is_closed = dfs(r + 1, c, grid, R, C) && is_closed;
        is_closed = dfs(r - 1, c, grid, R, C) && is_closed;
        is_closed = dfs(r, c + 1, grid, R, C) && is_closed;
        is_closed = dfs(r, c - 1, grid, R, C) && is_closed;

        return is_closed;
    }

    int closedIsland(std::vector<std::vector<int>>& grid) {
        int R = grid.size();
        if (R == 0) return 0;
        int C = grid[0].size();
        if (C == 0) return 0;

        int closed_islands_count = 0;

        for (int r = 0; r < R; ++r) {
            for (int c = 0; c < C; ++c) {
                if (grid[r][c] == 0) {
                    if (dfs(r, c, grid, R, C)) {
                        closed_islands_count++;
                    }
                }
            }
        }

        return closed_islands_count;
    }
};