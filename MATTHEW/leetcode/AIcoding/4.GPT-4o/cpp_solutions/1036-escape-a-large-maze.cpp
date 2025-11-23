class Solution {
public:
    bool canEscape(vector<vector<int>>& maze, vector<int>& start, vector<int>& destination) {
        int m = maze.size(), n = maze[0].size();
        vector<vector<bool>> visited(m, vector<bool>(n, false));
        queue<pair<int, int>> q;
        q.push({start[0], start[1]});
        visited[start[0]][start[1]] = true;

        vector<int> directions = {0, 1, 0, -1, 0}; // right, down, left, up

        while (!q.empty()) {
            auto [x, y] = q.front();
            q.pop();
            if (x == destination[0] && y == destination[1]) return true;

            for (int i = 0; i < 4; i++) {
                int nx = x, ny = y;
                while (nx + directions[i] >= 0 && nx + directions[i] < m && ny + directions[i + 1] >= 0 && ny + directions[i + 1] < n && maze[nx + directions[i]][ny + directions[i + 1]] == 0) {
                    nx += directions[i];
                    ny += directions[i + 1];
                }
                if (!visited[nx][ny]) {
                    visited[nx][ny] = true;
                    q.push({nx, ny});
                }
            }
        }
        return false;
    }
};