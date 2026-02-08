class Solution {
public:
    int minCost(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<vector<int>> cost(m, vector<int>(n, INT_MAX));
        cost[0][0] = 0;
        priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<pair<int, pair<int, int>>>> pq;
        pq.push({0, {0, 0}});

        vector<pair<int, int>> directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

        while (!pq.empty()) {
            auto [curCost, pos] = pq.top();
            pq.pop();
            int x = pos.first, y = pos.second;

            if (x == m - 1 && y == n - 1) {
                return curCost;
            }

            for (int i = 0; i < 4; i++) {
                int newX = x + directions[i].first;
                int newY = y + directions[i].second;
                if (newX >= 0 && newX < m && newY >= 0 && newY < n) {
                    int newCost = curCost + (grid[x][y] != i + 1);
                    if (newCost < cost[newX][newY]) {
                        cost[newX][newY] = newCost;
                        pq.push({newCost, {newX, newY}});
                    }
                }
            }
        }
        return -1; // Should never reach here
    }
};