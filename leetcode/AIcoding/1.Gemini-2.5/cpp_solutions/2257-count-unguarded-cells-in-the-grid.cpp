class Solution {
public:
    int countUnguarded(int m, int n, std::vector<std::vector<int>>& guards, std::vector<std::vector<int>>& walls) {
        std::vector<std::vector<int>> grid(m, std::vector<int>(n, 0)); // 0: empty, 1: guard, 2: wall, 3: guarded

        for (const auto& wall : walls) {
            grid[wall[0]][wall[1]] = 2;
        }

        for (const auto& guard : guards) {
            grid[guard[0]][guard[1]] = 1;
        }

        int dr[] = {-1, 1, 0, 0}; // Up, Down
        int dc[] = {0, 0, -1, 1}; // Left, Right

        for (const auto& guard : guards) {
            int r = guard[0];
            int c = guard[1];

            for (int i = 0; i < 4; ++i) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                while (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                    if (grid[nr][nc] == 1 || grid[nr][nc] == 2) { // Hit a guard or a wall
                        break;
                    }
                    if (grid[nr][nc] == 0) { // Empty cell, mark as guarded
                        grid[nr][nc] = 3;
                    }
                    nr += dr[i];
                    nc += dc[i];
                }
            }
        }

        int unguardedCount = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 0) {
                    unguardedCount++;
                }
            }
        }

        return unguardedCount;
    }
};