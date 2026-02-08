#include <vector>
#include <string>

class Solution {
public:
    bool isValidTicTacToeState(std::vector<std::string>& board) {
        int countX = 0;
        int countO = 0;

        for (int i = 0; i < 3; ++i) {
            for (int j = 0; j < 3; ++j) {
                if (board[i][j] == 'X') {
                    countX++;
                } else if (board[i][j] == 'O') {
                    countO++;
                }
            }
        }

        bool xWins = checkWin(board, 'X');
        bool oWins = checkWin(board, 'O');

        if (countO > countX || countX > countO + 1) {
            return false;
        }

        if (xWins && oWins) {
            return false;
        }

        if (oWins && countX != countO) {
            return false;
        }

        if (xWins && countX != countO + 1) {
            return false;
        }

        return true;
    }

private:
    bool checkWin(const std::vector<std::string>& board, char player) {
        for (int i = 0; i < 3; ++i) {
            if (board[i][0] == player && board[i][1] == player && board[i][2] == player) {
                return true;
            }
        }

        for (int j = 0; j < 3; ++j) {
            if (board[0][j] == player && board[1][j] == player && board[2][j] == player) {
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