#include <vector>

using namespace std;

class Solution {
public:
    int numRookCaptures(vector<vector<char>>& board) {
        int rookRow = -1, rookCol = -1;
        for (int i = 0; i < 8; ++i) {
            for (int j = 0; j < 8; ++j) {
                if (board[i][j] == 'R') {
                    rookRow = i;
                    rookCol = j;
                    break;
                }
            }
            if (rookRow != -1) break;
        }

        int captures = 0;

        for (int i = rookRow - 1; i >= 0; --i) {
            if (board[i][rookCol] == 'B') break;
            if (board[i][rookCol] == 'p') {
                captures++;
                break;
            }
        }

        for (int i = rookRow + 1; i < 8; ++i) {
            if (board[i][rookCol] == 'B') break;
            if (board[i][rookCol] == 'p') {
                captures++;
                break;
            }
        }

        for (int j = rookCol - 1; j >= 0; --j) {
            if (board[rookRow][j] == 'B') break;
            if (board[rookRow][j] == 'p') {
                captures++;
                break;
            }
        }

        for (int j = rookCol + 1; j < 8; ++j) {
            if (board[rookRow][j] == 'B') break;
            if (board[rookRow][j] == 'p') {
                captures++;
                break;
            }
        }

        return captures;
    }
};