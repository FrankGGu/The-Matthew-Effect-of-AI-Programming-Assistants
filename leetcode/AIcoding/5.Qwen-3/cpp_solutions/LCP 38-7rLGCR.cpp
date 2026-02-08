#include <iostream>
#include <vector>
#include <queue>
#include <utility>

using namespace std;

class Solution {
public:
    int guardCastle(vector<vector<int>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();
        vector<vector<bool>> visited(rows, vector<bool>(cols, false));
        queue<pair<int, int>> q;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (grid[i][j] == 1) {
                    q.push({i, j});
                    visited[i][j] = true;
                }
            }
        }

        int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        int result = 0;

        while (!q.empty()) {
            auto [x, y] = q.front();
            q.pop();

            for (auto& dir : directions) {
                int nx = x + dir[0];
                int ny = y + dir[1];

                if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && !visited[nx][ny]) {
                    visited[nx][ny] = true;
                    if (grid[nx][ny] == 0) {
                        result++;
                    }
                    q.push({nx, ny});
                }
            }
        }

        return result;
    }
};