#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int possibleDay(int day, vector<vector<int>>& grid, int rows, int cols) {
        vector<vector<bool>> visited(rows, vector<bool>(cols, false));
        queue<pair<int, int>> q;

        for (int j = 0; j < cols; ++j) {
            if (grid[0][j] <= day) {
                q.push({0, j});
                visited[0][j] = true;
            }
        }

        int dir[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!q.empty()) {
            auto [r, c] = q.front();
            q.pop();

            if (r == rows - 1) {
                return 1;
            }

            for (auto& [dr, dc] : dir) {
                int nr = r + dr;
                int nc = c + dc;

                if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && !visited[nr][nc] && grid[nr][nc] <= day) {
                    visited[nr][nc] = true;
                    q.push({nr, nc});
                }
            }
        }

        return 0;
    }

    int earliestDay(vector<vector<int>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();

        int left = 1, right = 1e9;
        int result = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (possibleDay(mid, grid, rows, cols)) {
                result = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return result;
    }
};