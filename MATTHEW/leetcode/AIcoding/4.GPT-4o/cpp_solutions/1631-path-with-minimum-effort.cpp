class Solution {
public:
    int minimumEffortPath(vector<vector<int>>& heights) {
        int m = heights.size(), n = heights[0].size();
        vector<vector<int>> effort(m, vector<int>(n, INT_MAX));
        effort[0][0] = 0;

        auto cmp = [](const array<int, 3>& a, const array<int, 3>& b) {
            return a[0] > b[0];
        };

        priority_queue<array<int, 3>, vector<array<int, 3>>, decltype(cmp)> pq(cmp);
        pq.push({0, 0, 0});

        vector<int> dir = {0, 1, 0, -1, 0};

        while (!pq.empty()) {
            auto [currEffort, x, y] = pq.top();
            pq.pop();
            if (x == m - 1 && y == n - 1) return currEffort;

            for (int i = 0; i < 4; ++i) {
                int nx = x + dir[i], ny = y + dir[i + 1];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                    int newEffort = max(currEffort, abs(heights[nx][ny] - heights[x][y]));
                    if (newEffort < effort[nx][ny]) {
                        effort[nx][ny] = newEffort;
                        pq.push({newEffort, nx, ny});
                    }
                }
            }
        }
        return 0;
    }
};