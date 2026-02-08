#include <vector>
#include <queue>
#include <tuple>

using namespace std;

int minPushBox(vector<vector<char>>& grid) {
    int m = grid.size();
    int n = grid[0].size();

    int playerX, playerY, boxX, boxY, targetX, targetY;
    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            if (grid[i][j] == 'S') {
                playerX = i;
                playerY = j;
            } else if (grid[i][j] == 'B') {
                boxX = i;
                boxY = j;
            } else if (grid[i][j] == 'T') {
                targetX = i;
                targetY = j;
            }
        }
    }

    vector<vector<vector<vector<bool>>>> visited(m, vector<vector<vector<bool>>>(n, vector<vector<bool>>(m, vector<bool>(n, false))));
    queue<tuple<int, int, int, int, int>> q;
    q.push({playerX, playerY, boxX, boxY, 0});
    visited[playerX][playerY][boxX][boxY] = true;

    int dx[] = {0, 0, 1, -1};
    int dy[] = {1, -1, 0, 0};

    while (!q.empty()) {
        auto [pX, pY, bX, bY, moves] = q.front();
        q.pop();

        if (bX == targetX && bY == targetY) {
            return moves;
        }

        for (int i = 0; i < 4; ++i) {
            int newPX = pX + dx[i];
            int newPY = pY + dy[i];

            if (newPX >= 0 && newPX < m && newPY >= 0 && newPY < n && grid[newPX][newPY] != '#') {
                if (newPX == bX && newPY == bY) {
                    int newBX = bX + dx[i];
                    int newBY = bY + dy[i];

                    if (newBX >= 0 && newBX < m && newBY >= 0 && newBY < n && grid[newBX][newBY] != '#') {
                        if (!visited[newPX][newPY][newBX][newBY]) {
                            visited[newPX][newPY][newBX][newBY] = true;
                            q.push({newPX, newPY, newBX, newBY, moves + 1});
                        }
                    }
                } else {
                    if (!visited[newPX][newPY][bX][bY]) {
                        visited[newPX][newPY][bX][bY] = true;
                        q.push({newPX, newPY, bX, bY, moves});
                    }
                }
            }
        }
    }

    return -1;
}