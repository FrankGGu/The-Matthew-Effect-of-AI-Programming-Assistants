class Solution {
public:
    int shortestPath(vector<vector<int>>& grid, int k) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> visited(m, vector<int>(n, -1));
        queue<vector<int>> q;
        q.push({0, 0, 0, k});
        visited[0][0] = k;

        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!q.empty()) {
            auto curr = q.front();
            q.pop();
            int x = curr[0], y = curr[1], steps = curr[2], remaining = curr[3];

            if (x == m - 1 && y == n - 1) {
                return steps;
            }

            for (auto& dir : dirs) {
                int nx = x + dir[0];
                int ny = y + dir[1];

                if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                    int new_remaining = remaining - grid[nx][ny];
                    if (new_remaining >= 0 && (visited[nx][ny] == -1 || new_remaining > visited[nx][ny])) {
                        visited[nx][ny] = new_remaining;
                        q.push({nx, ny, steps + 1, new_remaining});
                    }
                }
            }
        }

        return -1;
    }
};