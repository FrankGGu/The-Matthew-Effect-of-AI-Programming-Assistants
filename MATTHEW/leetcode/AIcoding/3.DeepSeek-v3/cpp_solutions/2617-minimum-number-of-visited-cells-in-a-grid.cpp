#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int minimumVisitedCells(vector<vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) return -1;
        int n = grid[0].size();
        if (n == 0) return -1;

        vector<vector<int>> dist(m, vector<int>(n, INT_MAX));
        dist[0][0] = 1;

        priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<pair<int, pair<int, int>>>> pq;
        pq.push({1, {0, 0}});

        while (!pq.empty()) {
            auto current = pq.top();
            pq.pop();
            int d = current.first;
            int i = current.second.first;
            int j = current.second.second;

            if (i == m - 1 && j == n - 1) {
                return d;
            }

            if (d > dist[i][j]) continue;

            int maxJump = grid[i][j];
            for (int k = 1; k <= maxJump; ++k) {
                if (i + k < m) {
                    if (dist[i + k][j] > d + 1) {
                        dist[i + k][j] = d + 1;
                        pq.push({dist[i + k][j], {i + k, j}});
                    }
                }
                if (j + k < n) {
                    if (dist[i][j + k] > d + 1) {
                        dist[i][j + k] = d + 1;
                        pq.push({dist[i][j + k], {i, j + k}});
                    }
                }
            }
        }

        return -1;
    }
};