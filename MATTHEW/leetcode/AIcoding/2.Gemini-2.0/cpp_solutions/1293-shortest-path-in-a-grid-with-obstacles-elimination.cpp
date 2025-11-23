#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int shortestPath(vector<vector<int>>& grid, int k) {
        int m = grid.size();
        int n = grid[0].size();

        if (m == 1 && n == 1) return 0;

        vector<vector<vector<int>>> visited(m, vector<vector<int>>(n, vector<int>(k + 1, -1)));
        queue<tuple<int, int, int, int>> q; // row, col, obstacles eliminated, steps

        q.push({0, 0, 0, 0});
        visited[0][0][0] = 0;

        int dr[] = {0, 0, 1, -1};
        int dc[] = {1, -1, 0, 0};

        while (!q.empty()) {
            auto [row, col, obs, steps] = q.front();
            q.pop();

            for (int i = 0; i < 4; ++i) {
                int newRow = row + dr[i];
                int newCol = col + dc[i];

                if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n) {
                    if (grid[newRow][newCol] == 0) {
                        if (visited[newRow][newCol][obs] == -1) {
                            visited[newRow][newCol][obs] = steps + 1;
                            q.push({newRow, newCol, obs, steps + 1});
                            if (newRow == m - 1 && newCol == n - 1) return steps + 1;
                        }
                    } else {
                        if (obs < k) {
                            if (visited[newRow][newCol][obs + 1] == -1) {
                                visited[newRow][newCol][obs + 1] = steps + 1;
                                q.push({newRow, newCol, obs + 1, steps + 1});
                                if (newRow == m - 1 && newCol == n - 1) return steps + 1;
                            }
                        }
                    }
                }
            }
        }

        return -1;
    }
};