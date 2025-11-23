#include <iostream>
#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int minCost(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        vector<vector<int>> dist(m, vector<int>(n, INT_MAX));
        vector<vector<int>> dirs{{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

        queue<pair<int, int>> q;
        q.push({0, 0});
        dist[0][0] = 0;

        while (!q.empty()) {
            auto [i, j] = q.front();
            q.pop();

            for (int d = 0; d < 4; ++d) {
                int ni = i + dirs[d][0];
                int nj = j + dirs[d][1];

                if (ni >= 0 && ni < m && nj >= 0 && nj < n) {
                    int cost = (d == grid[i][j] - 1) ? 0 : 1;
                    if (dist[ni][nj] > dist[i][j] + cost) {
                        dist[ni][nj] = dist[i][j] + cost;
                        q.push({ni, nj});
                    }
                }
            }
        }

        return dist[m - 1][n - 1];
    }
};