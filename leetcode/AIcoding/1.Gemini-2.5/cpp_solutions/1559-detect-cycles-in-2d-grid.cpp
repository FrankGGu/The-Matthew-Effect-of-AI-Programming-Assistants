#include <vector>

class Solution {
public:
    int R, C;
    std::vector<std::vector<bool>> visited;
    std::vector<int> dr = {-1, 1, 0, 0};
    std::vector<int> dc = {0, 0, -1, 1};

    bool isValid(int r, int c) {
        return r >= 0 && r < R && c >= 0 && c < C;
    }

    bool dfs(int r, int c, int pr, int pc, char target_char, const std::vector<std::vector<char>>& grid) {
        visited[r][c] = true;

        for (int i = 0; i < 4; ++i) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (isValid(nr, nc) && grid[nr][nc] == target_char) {
                if (nr == pr && nc == pc) {
                    continue;
                }
                if (visited[nr][nc]) {
                    return true;
                }
                if (dfs(nr, nc, r, c, target_char, grid)) {
                    return true;
                }
            }
        }
        return false;
    }

    bool hasCycle(std::vector<std::vector<char>>& grid) {
        R = grid.size();
        C = grid[0].size();
        visited.assign(R, std::vector<bool>(C, false));

        for (int i = 0; i < R; ++i) {
            for (int j = 0; j < C; ++j) {
                if (!visited[i][j]) {
                    if (dfs(i, j, -1, -1, grid[i][j], grid)) {
                        return true;
                    }
                }
            }
        }
        return false;
    }
};