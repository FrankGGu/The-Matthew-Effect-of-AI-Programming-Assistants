#include <vector>
#include <cmath>

class Solution {
public:
    std::vector<std::vector<int>> bubbleBobble(std::vector<std::vector<int>>& board) {
        int R = board.size();
        if (R == 0) return {};
        int C = board[0].size();
        if (C == 0) return {};

        bool changed = true;
        while (changed) {
            changed = false;

            for (int r = 0; r < R; ++r) {
                for (int c = 0; c <= C - 3; ++c) {
                    int val = std::abs(board[r][c]);
                    if (val != 0 && std::abs(board[r][c+1]) == val && std::abs(board[r][c+2]) == val) {
                        board[r][c] = -val;
                        board[r][c+1] = -val;
                        board[r][c+2] = -val;
                        changed = true;
                    }
                }
            }

            for (int c = 0; c < C; ++c) {
                for (int r = 0; r <= R - 3; ++r) {
                    int val = std::abs(board[r][c]);
                    if (val != 0 && std::abs(board[r+1][c]) == val && std::abs(board[r+2][c]) == val) {
                        board[r][c] = -val;
                        board[r+1][c] = -val;
                        board[r+2][c] = -val;
                        changed = true;
                    }
                }
            }

            if (changed) {
                for (int c = 0; c < C; ++c) {
                    int write_idx = R - 1; 
                    for (int r = R - 1; r >= 0; --r) {
                        if (board[r][c] > 0) { 
                            board[write_idx][c] = board[r][c];
                            write_idx--;
                        }
                    }
                    while (write_idx >= 0) {
                        board[write_idx][c] = 0;
                        write_idx--;
                    }
                }
            }
        }
        return board;
    }
};