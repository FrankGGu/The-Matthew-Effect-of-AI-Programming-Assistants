#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int countSubIslands(vector<vector<int>>& grid1, vector<vector<int>>& grid2) {
        int rows = grid2.size();
        int cols = grid2[0].size();
        int subIslandCount = 0;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (grid2[i][j] == 1) {
                    bool isSubIsland = true;
                    queue<pair<int, int>> q;
                    q.push({i, j});
                    grid2[i][j] = 0;

                    while (!q.empty()) {
                        auto [x, y] = q.front();
                        q.pop();

                        if (grid1[x][y] != 1) {
                            isSubIsland = false;
                        }

                        for (auto [dx, dy] : vector<pair<int, int>>{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}) {
                            int nx = x + dx;
                            int ny = y + dy;
                            if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && grid2[nx][ny] == 1) {
                                grid2[nx][ny] = 0;
                                q.push({nx, ny});
                            }
                        }
                    }

                    if (isSubIsland) {
                        ++subIslandCount;
                    }
                }
            }
        }

        return subIslandCount;
    }
};