class Solution {
public:
    int minSteps(vector<vector<int>>& maze, vector<int>& start, vector<int>& end) {
        int m = maze.size(), n = maze[0].size();
        vector<vector<int>> dist(m, vector<int>(n, INT_MAX));
        queue<pair<int, int>> q;
        q.push({start[0], start[1]});
        dist[start[0]][start[1]] = 0;

        vector<int> directions = {0, 1, 0, -1, 0};

        while (!q.empty()) {
            auto [x, y] = q.front(); q.pop();

            for (int i = 0; i < 4; ++i) {
                int nx = x, ny = y;
                while (nx + directions[i] >= 0 && nx + directions[i] < m && 
                       ny + directions[i + 1] >= 0 && ny + directions[i + 1] < n && 
                       maze[nx + directions[i]][ny + directions[i + 1]] == 0) {
                    nx += directions[i];
                    ny += directions[i + 1];
                }

                if (dist[nx][ny] > dist[x][y] + 1) {
                    dist[nx][ny] = dist[x][y] + 1;
                    q.push({nx, ny});
                }
            }
        }

        return dist[end[0]][end[1]] == INT_MAX ? -1 : dist[end[0]][end[1]];
    }
};