#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int iceBreakingGame(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<bool>> visited(m, vector<bool>(n, false));
        queue<pair<int, int>> q;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    q.push({i, j});
                    visited[i][j] = true;
                    break;
                }
            }
            if (!q.empty()) break;
        }

        int days = 0;
        int dx[] = {0, 0, 1, -1};
        int dy[] = {1, -1, 0, 0};

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                int x = q.front().first;
                int y = q.front().second;
                q.pop();

                for (int k = 0; k < 4; ++k) {
                    int nx = x + dx[k];
                    int ny = y + dy[k];

                    if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] == 0 && !visited[nx][ny]) {
                        q.push({nx, ny});
                        visited[nx][ny] = true;
                    }
                }
            }
            days++;
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 0 && !visited[i][j]) {
                    return -1;
                }
            }
        }

        return days - 1;
    }
};