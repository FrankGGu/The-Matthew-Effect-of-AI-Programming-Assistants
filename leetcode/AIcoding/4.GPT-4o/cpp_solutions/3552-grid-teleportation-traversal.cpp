class Solution {
public:
    int gridTeleportationTraversal(vector<vector<int>>& grid) {
        int n = grid.size(), m = grid[0].size();
        vector<vector<int>> dist(n, vector<int>(m, INT_MAX));
        queue<pair<int, int>> q;

        dist[0][0] = 0;
        q.push({0, 0});

        while (!q.empty()) {
            auto [x, y] = q.front();
            q.pop();

            for (int i = 0; i < n; ++i) {
                if (grid[i][y] == 0 && dist[i][y] > dist[x][y] + 1) {
                    dist[i][y] = dist[x][y] + 1;
                    q.push({i, y});
                }
            }
            for (int j = 0; j < m; ++j) {
                if (grid[x][j] == 0 && dist[x][j] > dist[x][y] + 1) {
                    dist[x][j] = dist[x][y] + 1;
                    q.push({x, j});
                }
            }
        }

        return dist[n-1][m-1] == INT_MAX ? -1 : dist[n-1][m-1];
    }
};