#include <vector>
#include <iostream>

using namespace std;

class Solution {
public:
    bool isSafe(int x, int y, vector<vector<int>>& board, int n) {
        return (x >= 0 && x < n && y >= 0 && y < n && board[x][y] == -1);
    }

    bool solveKTUtil(vector<vector<int>>& board, int x, int y, int movei, int n, vector<int>& dx, vector<int>& dy) {
        if (movei == n * n)
            return true;

        for (int k = 0; k < 8; k++) {
            int next_x = x + dx[k];
            int next_y = y + dy[k];

            if (isSafe(next_x, next_y, board, n)) {
                board[next_x][next_y] = movei;
                if (solveKTUtil(board, next_x, next_y, movei + 1, n, dx, dy))
                    return true;
                else
                    board[next_x][next_y] = -1;
            }
        }
        return false;
    }

    bool tour(int n) {
        vector<vector<int>> board(n, vector<int>(n, -1));
        vector<int> dx = {2, 1, -1, -2, -2, -1, 1, 2};
        vector<int> dy = {1, 2, 2, 1, -1, -2, -2, -1};

        board[0][0] = 0;

        if (!solveKTUtil(board, 0, 0, 1, n, dx, dy))
            return false;

        return true;
    }

    bool checkKnightTourConfiguration(vector<vector<int>>& board) {
        int n = board.size();
        if (n == 0)
            return false;

        vector<int> dx = {2, 1, -1, -2, -2, -1, 1, 2};
        vector<int> dy = {1, 2, 2, 1, -1, -2, -2, -1};

        int startRow = -1, startCol = -1;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (board[i][j] == 0) {
                    startRow = i;
                    startCol = j;
                    break;
                }
            }
            if (startRow != -1)
                break;
        }

        if (startRow == -1)
            return false;

        vector<vector<int>> copyBoard = board;
        if (solveKTUtil(copyBoard, startRow, startCol, 1, n, dx, dy)) {
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    if (copyBoard[i][j] != board[i][j])
                        return false;
                }
            }
            return true;
        }

        return false;
    }
};