#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumSafenessFactor(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<vector<int>> dist(n, vector<int>(n, -1));
        queue<pair<int, int>> q;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    dist[i][j] = 0;
                    q.push({i, j});
                }
            }
        }

        int dx[] = {0, 0, 1, -1};
        int dy[] = {1, -1, 0, 0};

        while (!q.empty()) {
            int x = q.front().first;
            int y = q.front().second;
            q.pop();

            for (int i = 0; i < 4; ++i) {
                int nx = x + dx[i];
                int ny = y + dy[i];

                if (nx >= 0 && nx < n && ny >= 0 && ny < n && dist[nx][ny] == -1) {
                    dist[nx][ny] = dist[x][y] + 1;
                    q.push({nx, ny});
                }
            }
        }

        int low = 0, high = n * n;
        int ans = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            vector<vector<bool>> visited(n, vector<bool>(n, false));
            queue<pair<int, int>> q2;

            if (dist[0][0] >= mid) {
                q2.push({0, 0});
                visited[0][0] = true;

                while (!q2.empty()) {
                    int x = q2.front().first;
                    int y = q2.front().second;
                    q2.pop();

                    if (x == n - 1 && y == n - 1) {
                        ans = mid;
                        low = mid + 1;
                        goto next_iter;
                    }

                    for (int i = 0; i < 4; ++i) {
                        int nx = x + dx[i];
                        int ny = y + dy[i];

                        if (nx >= 0 && nx < n && ny >= 0 && ny < n && !visited[nx][ny] && dist[nx][ny] >= mid) {
                            visited[nx][ny] = true;
                            q2.push({nx, ny});
                        }
                    }
                }
            }
            high = mid - 1;

            next_iter:;
        }

        return ans;
    }
};