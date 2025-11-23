class Solution {
public:
    int orangesRotting(vector<vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) return 0;
        int n = grid[0].size();
        queue<pair<int, int>> q;
        int fresh = 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 2) {
                    q.push({i, j});
                } else if (grid[i][j] == 1) {
                    fresh++;
                }
            }
        }

        if (fresh == 0) return 0;

        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        int minutes = -1;

        while (!q.empty()) {
            int size = q.size();
            minutes++;
            for (int i = 0; i < size; ++i) {
                auto curr = q.front();
                q.pop();
                for (auto dir : dirs) {
                    int x = curr.first + dir[0];
                    int y = curr.second + dir[1];
                    if (x >= 0 && x < m && y >= 0 && y < n && grid[x][y] == 1) {
                        grid[x][y] = 2;
                        fresh--;
                        q.push({x, y});
                    }
                }
            }
        }

        return fresh == 0 ? minutes : -1;
    }
};