#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int maxMoves(vector<vector<int>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();
        vector<vector<int>> visited(rows, vector<int>(cols, 0));
        queue<pair<int, int>> q;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (grid[i][j] == 1) {
                    q.push({i, j});
                    visited[i][j] = 1;
                }
            }
        }

        int moves = 0;
        int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!q.empty()) {
            int size = q.size();
            bool hasMove = false;

            for (int k = 0; k < size; ++k) {
                auto [x, y] = q.front();
                q.pop();

                for (int d = 0; d < 4; ++d) {
                    int nx = x + directions[d][0];
                    int ny = y + directions[d][1];

                    if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && grid[nx][ny] == 0 && !visited[nx][ny]) {
                        visited[nx][ny] = 1;
                        q.push({nx, ny});
                        hasMove = true;
                    }
                }
            }

            if (hasMove) {
                moves++;
            }
        }

        return moves;
    }
};