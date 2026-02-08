#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    string tictactoe(vector<int>& moves) {
        vector<vector<int>> board(3, vector<int>(3, 0));
        for (int i = 0; i < moves.size(); i += 2) {
            int x = moves[i] / 3;
            int y = moves[i] % 3;
            board[x][y] = 1;
        }
        for (int i = 1; i < moves.size(); i += 2) {
            int x = moves[i] / 3;
            int y = moves[i] % 3;
            board[x][y] = 2;
        }

        for (int i = 0; i < 3; ++i) {
            if (board[i][0] == board[i][1] && board[i][1] == board[i][2] && board[i][0] != 0)
                return (board[i][0] == 1) ? "A" : "B";
            if (board[0][i] == board[1][i] && board[1][i] == board[2][i] && board[0][i] != 0)
                return (board[0][i] == 1) ? "A" : "B";
        }

        if (board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0] != 0)
            return (board[0][0] == 1) ? "A" : "B";
        if (board[0][2] == board[1][1] && board[1][1] == board[2][0] && board[0][2] != 0)
            return (board[0][2] == 1) ? "A" : "B";

        return (moves.size() == 9) ? "Draw" : "Pending";
    }
};