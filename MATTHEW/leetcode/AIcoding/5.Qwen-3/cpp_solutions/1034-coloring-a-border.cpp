#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<vector<int>> colorBorder(int rows, int cols, vector<vector<int>>& grid, int x, int y, int color) {
        int originalColor = grid[x][y];
        if (originalColor == color) return grid;

        vector<vector<bool>> visited(rows, vector<bool>(cols, false));
        queue<pair<int, int>> q;
        q.push({x, y});
        visited[x][y] = true;

        int dx[] = {-1, 0, 1, 0};
        int dy[] = {0, 1, 0, -1};

        while (!q.empty()) {
            auto [r, c] = q.front();
            q.pop();

            for (int i = 0; i < 4; ++i) {
                int nr = r + dx[i];
                int nc = c + dy[i];

                if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && grid[nr][nc] == originalColor && !visited[nr][nc]) {
                    visited[nr][nc] = true;
                    q.push({nr, nc});
                }
            }
        }

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (visited[i][j]) {
                    bool isBorder = false;
                    for (int k = 0; k < 4; ++k) {
                        int ni = i + dx[k];
                        int nj = j + dy[k];
                        if (ni < 0 || ni >= rows || nj < 0 || nj >= cols || !visited[ni][nj]) {
                            isBorder = true;
                            break;
                        }
                    }
                    if (isBorder) {
                        grid[i][j] = color;
                    }
                }
            }
        }

        return grid;
    }
};