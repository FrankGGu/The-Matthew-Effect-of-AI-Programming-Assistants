#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int snakeInMatrix(vector<vector<int>>& matrix) {
        int n = matrix.size();
        if (n == 0) return 0;
        int m = matrix[0].size();
        if (m == 0) return 0;

        vector<vector<int>> dist(n, vector<int>(m, -1));
        queue<pair<int, int>> q;

        q.push({0, 0});
        dist[0][0] = 1;

        int dx[] = {0, 0, 1, -1};
        int dy[] = {1, -1, 0, 0};

        while (!q.empty()) {
            int x = q.front().first;
            int y = q.front().second;
            q.pop();

            for (int i = 0; i < 4; ++i) {
                int nx = x + dx[i];
                int ny = y + dy[i];

                if (nx >= 0 && nx < n && ny >= 0 && ny < m && matrix[nx][ny] == matrix[x][y] + 1 && dist[nx][ny] == -1) {
                    dist[nx][ny] = dist[x][y] + 1;
                    q.push({nx, ny});
                }
            }
        }

        int max_dist = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                max_dist = max(max_dist, dist[i][j]);
            }
        }

        return max_dist;
    }
};