#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int catMouseGame(vector<int>& mouse, vector<int>& cat) {
        int m = mouse[0], n = mouse[1], cm = cat[0], cn = cat[1];
        int size = 100;
        vector<vector<vector<int>>> dp(size, vector<vector<int>>(size, vector<int>(2, -1)));
        queue<pair<int, int>> q;

        for (int i = 0; i < size; ++i) {
            for (int j = 0; j < size; ++j) {
                dp[i][j][0] = 0;
                dp[i][j][1] = 0;
                if (i == j) {
                    dp[i][j][0] = 2;
                    dp[i][j][1] = 2;
                    q.push({i, j});
                }
            }
        }

        for (int i = 0; i < size; ++i) {
            for (int j = 0; j < size; ++j) {
                for (int k = 0; k < 2; ++k) {
                    if (dp[i][j][k] != -1) continue;
                    dp[i][j][k] = 0;
                }
            }
        }

        while (!q.empty()) {
            auto [x, y] = q.front();
            q.pop();
            for (int i = 0; i < 4; ++i) {
                int nx = x + (i == 0 ? -1 : i == 1 ? 1 : 0);
                int ny = y + (i == 2 ? -1 : i == 3 ? 1 : 0);
                if (nx < 0 || nx >= size || ny < 0 || ny >= size) continue;
                if (dp[nx][ny][1] != -1) continue;
                if (dp[x][y][0] == 2) {
                    dp[nx][ny][1] = 2;
                    q.push({nx, ny});
                } else if (dp[x][y][0] == 1) {
                    dp[nx][ny][1] = 1;
                    q.push({nx, ny});
                }
            }

            for (int i = 0; i < 4; ++i) {
                int nx = x + (i == 0 ? -1 : i == 1 ? 1 : 0);
                int ny = y + (i == 2 ? -1 : i == 3 ? 1 : 0);
                if (nx < 0 || nx >= size || ny < 0 || ny >= size) continue;
                if (dp[nx][ny][0] != -1) continue;
                if (dp[x][y][1] == 2) {
                    dp[nx][ny][0] = 2;
                    q.push({nx, ny});
                } else if (dp[x][y][1] == 1) {
                    dp[nx][ny][0] = 1;
                    q.push({nx, ny});
                }
            }
        }

        return dp[m][n][0];
    }
};