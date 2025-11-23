#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int flipChess(vector<string>& chessboard) {
        int m = chessboard.size();
        int n = chessboard[0].size();
        int max_flips = 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (chessboard[i][j] == '.') {
                    max_flips = max(max_flips, bfs(chessboard, i, j));
                }
            }
        }

        return max_flips;
    }

private:
    int bfs(vector<string> chessboard, int start_row, int start_col) {
        int m = chessboard.size();
        int n = chessboard[0].size();
        chessboard[start_row][start_col] = 'X';
        int flips = 0;
        queue<pair<int, int>> q;
        vector<pair<int, int>> flipped;

        for (int dr = -1; dr <= 1; ++dr) {
            for (int dc = -1; dc <= 1; ++dc) {
                if (dr == 0 && dc == 0) continue;

                int r = start_row + dr;
                int c = start_col + dc;
                bool found_x = false;
                vector<pair<int, int>> to_flip;

                while (r >= 0 && r < m && c >= 0 && c < n) {
                    if (chessboard[r][c] == '.') {
                        break;
                    } else if (chessboard[r][c] == 'X') {
                        found_x = true;
                        break;
                    } else {
                        to_flip.push_back({r, c});
                    }
                    r += dr;
                    c += dc;
                }

                if (found_x) {
                    for (auto p : to_flip) {
                        chessboard[p.first][p.second] = 'X';
                        flips++;
                        flipped.push_back(p);
                    }
                }
            }
        }

        for(auto p : flipped){
            chessboard[p.first][p.second] = 'O';
        }

        chessboard[start_row][start_col] = '.';
        return flips;
    }
};