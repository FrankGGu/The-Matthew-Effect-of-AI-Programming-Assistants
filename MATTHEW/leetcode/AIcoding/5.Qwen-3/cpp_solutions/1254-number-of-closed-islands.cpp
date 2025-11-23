#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int closedIsland(vector<vector<int>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();
        int count = 0;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (grid[i][j] == 0) {
                    bool isClosed = true;
                    queue<pair<int, int>> q;
                    q.push({i, j});
                    grid[i][j] = 1;

                    while (!q.empty()) {
                        auto [x, y] = q.front();
                        q.pop();

                        if (x == 0 || x == rows - 1 || y == 0 || y == cols - 1) {
                            isClosed = false;
                        }

                        int dx[] = {-1, 0, 1, 0};
                        int dy[] = {0, 1, 0, -1};

                        for (int k = 0; k < 4; ++k) {
                            int nx = x + dx[k];
                            int ny = y + dy[k];

                            if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && grid[nx][ny] == 0) {
                                grid[nx][ny] = 1;
                                q.push({nx, ny});
                            }
                        }
                    }

                    if (isClosed) {
                        ++count;
                    }
                }
            }
        }

        return count;
    }
};