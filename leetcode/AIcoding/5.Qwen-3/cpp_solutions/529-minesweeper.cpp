#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<vector<char>> updateBoard(vector<vector<char>>& board, vector<int>& click) {
        int m = board.size();
        int n = board[0].size();
        int x = click[0];
        int y = click[1];

        if (board[x][y] == 'M') {
            board[x][y] = 'X';
            return board;
        }

        if (board[x][y] != 'E') {
            return board;
        }

        vector<vector<int>> directions = {{-1, -1}, {-1, 0}, {-1, 1},
                                          {0, -1},          {0, 1},
                                          {1, -1},  {1, 0}, {1, 1}};

        queue<pair<int, int>> q;
        q.push({x, y});
        board[x][y] = 'B';

        while (!q.empty()) {
            auto [i, j] = q.front();
            q.pop();

            int count = 0;
            for (const auto& dir : directions) {
                int ni = i + dir[0];
                int nj = j + dir[1];
                if (ni >= 0 && ni < m && nj >= 0 && nj < n) {
                    if (board[ni][nj] == 'M') {
                        count++;
                    }
                }
            }

            if (count > 0) {
                board[i][j] = '0' + count;
            } else {
                for (const auto& dir : directions) {
                    int ni = i + dir[0];
                    int nj = j + dir[1];
                    if (ni >= 0 && ni < m && nj >= 0 && nj < n && board[ni][nj] == 'E') {
                        board[ni][nj] = 'B';
                        q.push({ni, nj});
                    }
                }
            }
        }

        return board;
    }
};