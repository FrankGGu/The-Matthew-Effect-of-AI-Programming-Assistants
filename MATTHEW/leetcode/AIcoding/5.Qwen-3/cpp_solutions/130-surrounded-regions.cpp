#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    void solve(vector<vector<char>>& board) {
        if (board.empty() || board[0].empty()) return;

        int rows = board.size();
        int cols = board[0].size();

        queue<pair<int, int>> q;

        for (int i = 0; i < rows; ++i) {
            if (board[i][0] == 'O') q.push({i, 0});
            if (board[i][cols - 1] == 'O') q.push({i, cols - 1});
        }

        for (int j = 0; j < cols; ++j) {
            if (board[0][j] == 'O') q.push({0, j});
            if (board[rows - 1][j] == 'O') q.push({rows - 1, j});
        }

        vector<vector<bool>> visited(rows, vector<bool>(cols, false));

        while (!q.empty()) {
            auto [x, y] = q.front();
            q.pop();

            if (visited[x][y]) continue;
            visited[x][y] = true;

            int dx[] = {-1, 1, 0, 0};
            int dy[] = {0, 0, -1, 1};

            for (int i = 0; i < 4; ++i) {
                int nx = x + dx[i];
                int ny = y + dy[i];

                if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && !visited[nx][ny] && board[nx][ny] == 'O') {
                    q.push({nx, ny});
                }
            }
        }

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (!visited[i][j] && board[i][j] == 'O') {
                    board[i][j] = 'X';
                }
            }
        }
    }
};