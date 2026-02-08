#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    int flipChess(std::vector<std::string>& chessboard) {
        int n = chessboard.size();
        int m = chessboard[0].size();
        int max_flips = 0;

        for (int r = 0; r < n; ++r) {
            for (int c = 0; c < m; ++c) {
                if (chessboard[r][c] == '.') {
                    int current_flips = countFlips(chessboard, r, c, n, m);
                    max_flips = std::max(max_flips, current_flips);
                }
            }
        }
        return max_flips;
    }

private:
    int countFlips(const std::vector<std::string>& board, int r, int c, int n, int m) {
        int total_flips = 0;
        int dr[] = {-1, -1, -1, 0, 0, 1, 1, 1};
        int dc[] = {-1, 0, 1, -1, 1, -1, 0, 1};

        for (int i = 0; i < 8; ++i) {
            int flips_in_dir = 0;
            int nr = r + dr[i];
            int nc = c + dc[i];

            while (nr >= 0 && nr < n && nc >= 0 && nc < m) {
                if (board[nr][nc] == 'O') {
                    flips_in_dir++;
                } else if (board[nr][nc] == 'X') {
                    total_flips += flips_in_dir;
                    break;
                } else {
                    break;
                }
                nr += dr[i];
                nc += dc[i];
            }
        }
        return total_flips;
    }
};