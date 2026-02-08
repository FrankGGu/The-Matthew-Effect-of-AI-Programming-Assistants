#include <vector>
#include <queue>

using namespace std;

int minCost(vector<vector<int>>& grid) {
    int m = grid.size();
    int n = grid[0].size();

    vector<vector<int>> cost(m, vector<int>(n, INT_MAX));
    cost[0][0] = 0;

    priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>, greater<tuple<int, int, int>>> pq;
    pq.emplace(0, 0, 0);

    vector<pair<int, int>> directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

    while (!pq.empty()) {
        auto [curr_cost, row, col] = pq.top();
        pq.pop();

        if (curr_cost > cost[row][col]) {
            continue;
        }

        for (int i = 0; i < 4; ++i) {
            int new_row = row + directions[i].first;
            int new_col = col + directions[i].second;

            if (new_row >= 0 && new_row < m && new_col >= 0 && new_col < n) {
                int new_cost = curr_cost + (grid[row][col] != i + 1);
                if (new_cost < cost[new_row][new_col]) {
                    cost[new_row][new_col] = new_cost;
                    pq.emplace(new_cost, new_row, new_col);
                }
            }
        }
    }

    return cost[m - 1][n - 1];
}