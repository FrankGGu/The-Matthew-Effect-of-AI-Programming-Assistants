#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool validTicTacToe(vector<string>& board) {
        int xCount = 0, oCount = 0;
        for (const string& row : board) {
            for (char c : row) {
                if (c == 'X') xCount++;
                else if (c == 'O') oCount++;
            }
        }

        if (xCount != oCount && xCount != oCount + 1) return false;

        bool xWin = false, oWin = false;

        for (int i = 0; i < 3; i++) {
            if (board[i][0] == board[i][1] && board[i][1] == board[i][2]) {
                if (board[i][0] == 'X') xWin = true;
                else if (board[i][0] == 'O') oWin = true;
            }
            if (board[0][i] == board[1][i] && board[1][i] == board[2][i]) {
                if (board[0][i] == 'X') xWin = true;
                else if (board[0][i] == 'O') oWin = true;
            }
        }

        if (board[0][0] == board[1][1] && board[1][1] == board[2][2]) {
            if (board[0][0] == 'X') xWin = true;
            else if (board[0][0] == 'O') oWin = true;
        }

        if (board[0][2] == board[1][1] && board[1][1] == board[2][0]) {
            if (board[0][2] == 'X') xWin = true;
            else if (board[0][2] == 'O') oWin = true;
        }

        if (xWin && oWin) return false;
        if (xWin && xCount != oCount + 1) return false;
        if (oWin && xCount != oCount) return false;

        return true;
    }
};