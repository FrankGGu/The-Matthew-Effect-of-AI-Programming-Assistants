#include <iostream>
#include <vector>
#include <queue>
#include <tuple>

using namespace std;

class Solution {
public:
    vector<vector<int>> highestRankedKItems(vector<vector<int>>& grid, int priceLower, int priceUpper, int k) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> result;

        vector<vector<int>> directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        priority_queue<tuple<int, int, int, int>, vector<tuple<int, int, int, int>>, greater<tuple<int, int, int, int>>> pq;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] >= priceLower && grid[i][j] <= priceUpper) {
                    pq.push({0, i, j, grid[i][j]});
                }
            }
        }

        vector<vector<bool>> visited(m, vector<bool>(n, false));

        while (!pq.empty() && result.size() < k) {
            auto [dist, x, y, val] = pq.top();
            pq.pop();

            if (visited[x][y]) continue;
            visited[x][y] = true;

            result.push_back({x, y});

            for (auto& dir : directions) {
                int nx = x + dir[0];
                int ny = y + dir[1];

                if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny]) {
                    if (grid[nx][ny] >= priceLower && grid[nx][ny] <= priceUpper) {
                        pq.push({dist + 1, nx, ny, grid[nx][ny]});
                    }
                }
            }
        }

        return result;
    }
};