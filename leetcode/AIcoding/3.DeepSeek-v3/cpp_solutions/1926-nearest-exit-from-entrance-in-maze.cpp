class Solution {
public:
    int nearestExit(vector<vector<char>>& maze, vector<int>& entrance) {
        int m = maze.size();
        int n = maze[0].size();
        vector<vector<int>> dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        queue<vector<int>> q;
        q.push({entrance[0], entrance[1], 0});
        maze[entrance[0]][entrance[1]] = '+';

        while (!q.empty()) {
            auto curr = q.front();
            q.pop();
            int r = curr[0], c = curr[1], steps = curr[2];

            for (auto& dir : dirs) {
                int nr = r + dir[0];
                int nc = c + dir[1];

                if (nr >= 0 && nr < m && nc >= 0 && nc < n && maze[nr][nc] == '.') {
                    if (nr == 0 || nr == m - 1 || nc == 0 || nc == n - 1) {
                        return steps + 1;
                    }
                    maze[nr][nc] = '+';
                    q.push({nr, nc, steps + 1});
                }
            }
        }

        return -1;
    }
};