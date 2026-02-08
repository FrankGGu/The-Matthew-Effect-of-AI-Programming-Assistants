#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int maxFish(vector<vector<int>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();
        vector<vector<bool>> visited(rows, vector<bool>(cols, false));
        int maxFish = 0;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (grid[i][j] > 0 && !visited[i][j]) {
                    queue<pair<int, int>> q;
                    q.push({i, j});
                    visited[i][j] = true;
                    int currentFish = grid[i][j];

                    while (!q.empty()) {
                        auto [x, y] = q.front();
                        q.pop();

                        int dx[] = {-1, 1, 0, 0};
                        int dy[] = {0, 0, -1, 1};

                        for (int k = 0; k < 4; ++k) {
                            int nx = x + dx[k];
                            int ny = y + dy[k];

                            if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && !visited[nx][ny] && grid[nx][ny] > 0) {
                                visited[nx][ny] = true;
                                q.push({nx, ny});
                                currentFish += grid[nx][ny];
                            }
                        }
                    }

                    maxFish = max(maxFish, currentFish);
                }
            }
        }

        return maxFish;
    }
};