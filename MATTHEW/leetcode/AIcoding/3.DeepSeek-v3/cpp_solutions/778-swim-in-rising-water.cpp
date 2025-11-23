class Solution {
public:
    int swimInWater(vector<vector<int>>& grid) {
        int n = grid.size();
        priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<pair<int, pair<int, int>>>> pq;
        pq.push({grid[0][0], {0, 0}});
        vector<vector<bool>> visited(n, vector<bool>(n, false));
        visited[0][0] = true;
        vector<pair<int, int>> dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        int res = 0;

        while (!pq.empty()) {
            auto curr = pq.top();
            pq.pop();
            int time = curr.first;
            int x = curr.second.first;
            int y = curr.second.second;
            res = max(res, time);

            if (x == n - 1 && y == n - 1) {
                return res;
            }

            for (auto dir : dirs) {
                int nx = x + dir.first;
                int ny = y + dir.second;
                if (nx >= 0 && nx < n && ny >= 0 && ny < n && !visited[nx][ny]) {
                    visited[nx][ny] = true;
                    pq.push({grid[nx][ny], {nx, ny}});
                }
            }
        }

        return res;
    }
};