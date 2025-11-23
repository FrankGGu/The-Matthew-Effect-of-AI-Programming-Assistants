#include <vector>
#include <queue>
#include <tuple>

using namespace std;

class Solution {
public:
    int minVisitedCells(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<vector<int>> visited(m, vector<int>(n, 0));
        queue<tuple<int, int, int>> q;
        q.emplace(0, 0, 1);
        visited[0][0] = 1;

        while (!q.empty()) {
            auto [x, y, steps] = q.front();
            q.pop();
            if (x == m - 1 && y == n - 1) return steps;

            for (int i = x + 1; i < m; i++) {
                if (grid[x][y] >= i - x && !visited[i][y]) {
                    visited[i][y] = 1;
                    q.emplace(i, y, steps + 1);
                }
            }
            for (int j = y + 1; j < n; j++) {
                if (grid[x][y] >= j - y && !visited[x][j]) {
                    visited[x][j] = 1;
                    q.emplace(x, j, steps + 1);
                }
            }
        }
        return -1;
    }
};