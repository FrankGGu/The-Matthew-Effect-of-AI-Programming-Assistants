#include <vector>

class Solution {
public:
    int numRookCaptures(std::vector<std::vector<char>>& board) {
        int rook_r = -1, rook_c = -1;
        for (int i = 0; i < 8; ++i) {
            for (int j = 0; j < 8; ++j) {
                if (board[i][j] == 'R') {
                    rook_r = i;
                    rook_c = j;
                    break;
                }
            }
            if (rook_r != -1) {
                break;
            }
        }

        int captures = 0;
        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        for (int i = 0; i < 4; ++i) {
            int r = rook_r + dr[i];
            int c = rook_c + dc[i];
            while (r >= 0 && r < 8 && c >= 0 && c < 8) {
                if (board[r][c] == 'p') {
                    captures++;
                    break;
                }
                if (board[r][c] == 'B') {
                    break;
                }
                r += dr[i];
                c += dc[i];
            }
        }

        return captures;
    }
};