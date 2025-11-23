#include <vector>
#include <queue>
#include <tuple>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minCost(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<vector<int>> cost(m, vector<int>(n, INT_MAX));
        priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>, greater<tuple<int, int, int>>> pq;

        cost[0][0] = 0;
        pq.emplace(0, 0, 0);

        vector<int> dr = {0, 1, 0, -1};
        vector<int> dc = {1, 0, -1, 0};

        while (!pq.empty()) {
            auto [c, r, col] = pq.top();
            pq.pop();

            if (r == m - 1 && col == n - 1) 
                return c;

            for (int i = 0; i < 4; ++i) {
                int nr = r + dr[i];
                int nc = col + dc[i];
                int newCost = c + (i + 1 != grid[r][col]);

                if (nr >= 0 && nr < m && nc >= 0 && nc < n && newCost < cost[nr][nc]) {
                    cost[nr][nc] = newCost;
                    pq.emplace(newCost, nr, nc);
                }
            }
        }

        return -1; // This line will never be reached
    }
};