#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    bool validTicTacToe(vector<string>& board) {
        int xCount = 0;
        int oCount = 0;
        for (int i = 0; i < 3; ++i) {
            for (int j = 0; j < 3; ++j) {
                if (board[i][j] == 'X') {
                    xCount++;
                } else if (board[i][j] == 'O') {
                    oCount++;
                }
            }
        }

        if (oCount > xCount || xCount - oCount > 1) {
            return false;
        }

        bool xWins = checkWin(board, 'X');
        bool oWins = checkWin(board, 'O');

        if (xWins && oWins) {
            return false;
        }

        if (xWins && xCount == oCount) {
            return false;
        }

        if (oWins && xCount > oCount) {
            return false;
        }

        return true;
    }

private:
    bool checkWin(vector<string>& board, char player) {
        for (int i = 0; i < 3; ++i) {
            if (board[i][0] == player && board[i][1] == player && board[i][2] == player) {
                return true;
            }
            if (board[0][i] == player && board[1][i] == player && board[2][i] == player) {
                return true;
            }
        }
        if (board[0][0] == player && board[1][1] == player && board[2][2] == player) {
            return true;
        }
        if (board[0][2] == player && board[1][1] == player && board[2][0] == player) {
            return true;
        }
        return false;
    }
};