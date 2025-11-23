#include <vector>
#include <string>

class Solution {
public:
    std::string tictactoe(std::vector<std::vector<int>>& moves) {
        std::vector<std::vector<int>> board(3, std::vector<int>(3, 0)); // 0: empty, 1: A, 2: B

        for (int i = 0; i < moves.size(); ++i) {
            int r = moves[i][0];
            int c = moves[i][1];
            int player = (i % 2 == 0) ? 1 : 2; 

            board[r][c] = player;

            if (checkWin(board, player)) {
                return (player == 1) ? "A" : "B";
            }
        }

        if (moves.size() == 9) {
            return "Draw";
        } else {
            return "Pending";
        }
    }

private:
    bool checkWin(const std::vector<std::vector<int>>& board, int player) {
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