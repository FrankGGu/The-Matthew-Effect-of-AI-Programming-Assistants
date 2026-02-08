class Solution {
public:
    vector<vector<int>> highestRankedKItems(vector<vector<int>>& grid, vector<int>& pricing, vector<int>& start, int k) {
        int m = grid.size();
        int n = grid[0].size();
        int low = pricing[0], high = pricing[1];
        int x = start[0], y = start[1];

        vector<vector<int>> res;
        vector<vector<int>> visited(m, vector<int>(n, 0));
        queue<pair<int, int>> q;
        q.push({x, y});
        visited[x][y] = 1;

        vector<vector<int>> dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!q.empty()) {
            int size = q.size();
            vector<vector<int>> level;
            for (int i = 0; i < size; ++i) {
                auto curr = q.front();
                q.pop();
                int r = curr.first, c = curr.second;
                if (grid[r][c] >= low && grid[r][c] <= high) {
                    level.push_back({grid[r][c], r, c});
                }
                for (auto& dir : dirs) {
                    int nr = r + dir[0];
                    int nc = c + dir[1];
                    if (nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] != 0 && !visited[nr][nc]) {
                        visited[nr][nc] = 1;
                        q.push({nr, nc});
                    }
                }
            }
            sort(level.begin(), level.end());
            for (auto& item : level) {
                if (res.size() < k) {
                    res.push_back({item[1], item[2]});
                } else {
                    break;
                }
            }
            if (res.size() == k) break;
        }
        return res;
    }
};