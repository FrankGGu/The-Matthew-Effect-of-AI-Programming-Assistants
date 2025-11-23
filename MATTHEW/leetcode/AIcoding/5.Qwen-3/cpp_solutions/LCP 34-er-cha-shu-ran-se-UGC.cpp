#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minTimeToRot(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> time(m, vector<int>(n, -1));
        vector<pair<int, int>> queue;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 2) {
                    queue.push_back({i, j});
                    time[i][j] = 0;
                }
            }
        }

        int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        int maxTime = 0;

        for (int i = 0; i < queue.size(); ++i) {
            int x = queue[i].first;
            int y = queue[i].second;

            for (int d = 0; d < 4; ++d) {
                int nx = x + directions[d][0];
                int ny = y + directions[d][1];

                if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] == 1 && time[nx][ny] == -1) {
                    time[nx][ny] = time[x][y] + 1;
                    maxTime = max(maxTime, time[nx][ny]);
                    queue.push_back({nx, ny});
                }
            }
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1 && time[i][j] == -1) {
                    return -1;
                }
            }
        }

        return maxTime;
    }
};