#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int flipChess(vector<vector<char>>& board) {
        int rows = board.size();
        int cols = board[0].size();
        int maxFlips = 0;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (board[i][j] == ' ') {
                    int count = 0;
                    vector<vector<bool>> visited(rows, vector<bool>(cols, false));
                    queue<pair<int, int>> q;
                    q.push({i, j});
                    visited[i][j] = true;

                    while (!q.empty()) {
                        auto [x, y] = q.front();
                        q.pop();

                        for (int dx = -1; dx <= 1; ++dx) {
                            for (int dy = -1; dy <= 1; ++dy) {
                                if (dx == 0 && dy == 0) continue;

                                int nx = x + dx;
                                int ny = y + dy;
                                int flipCount = 0;

                                while (nx >= 0 && nx < rows && ny >= 0 && ny < cols && board[nx][ny] == 'o') {
                                    flipCount++;
                                    nx += dx;
                                    ny += dy;
                                }

                                if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && board[nx][ny] == 'x' && flipCount > 0) {
                                    count += flipCount;
                                    for (int k = 1; k <= flipCount; ++k) {
                                        int px = x + dx * k;
                                        int py = y + dy * k;
                                        if (!visited[px][py]) {
                                            visited[px][py] = true;
                                            q.push({px, py});
                                        }
                                    }
                                }
                            }
                        }
                    }

                    maxFlips = max(maxFlips, count);
                }
            }
        }

        return maxFlips;
    }
};