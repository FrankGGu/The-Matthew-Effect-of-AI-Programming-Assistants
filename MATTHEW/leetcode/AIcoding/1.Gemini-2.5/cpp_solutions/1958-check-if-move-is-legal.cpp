#include <vector>

class Solution {
public:
    bool checkMove(std::vector<std::vector<char>>& board, int rMove, int cMove, char color) {
        int R = 8, C = 8;
        int dr[] = {-1, -1, -1, 0, 0, 1, 1, 1};
        int dc[] = {-1, 0, 1, -1, 1, -1, 0, 1};

        for (int i = 0; i < 8; ++i) {
            int r = rMove + dr[i];
            int c = cMove + dc[i];
            int length = 0;

            while (r >= 0 && r < R && c >= 0 && c < C) {
                if (board[r][c] == '.') {
                    break;
                }
                if (board[r][c] == color) {
                    if (length > 0) {
                        return true;
                    }
                    break;
                }
                length++;
                r += dr[i];
                c += dc[i];
            }
        }

        return false;
    }
};