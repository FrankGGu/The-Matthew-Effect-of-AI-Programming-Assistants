#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minMovesToCaptureTheQueen(int rookRow, int rookCol, int bishopRow, int bishopCol, int queenRow, int queenCol) {
    int moves = 2;
    int rook_moves = INT_MAX;
    int bishop_moves = INT_MAX;

    // Rook moves
    bool blocked_up = false;
    for (int i = rookRow - 1; i >= 1; i--) {
        if (i == queenRow && rookCol == queenCol) {
            if (!blocked_up) {
                rook_moves = rookRow - queenRow;
            }
            break;
        }
        if (i == bishopRow && rookCol == bishopCol) {
            blocked_up = true;
        }
    }

    bool blocked_down = false;
    for (int i = rookRow + 1; i <= 8; i++) {
        if (i == queenRow && rookCol == queenCol) {
            if (!blocked_down) {
                int current_dist = i - rookRow;
                rook_moves = (rook_moves == INT_MAX) ? current_dist : (current_dist < rook_moves ? current_dist : rook_moves);
            }
            break;
        }
        if (i == bishopRow && rookCol == bishopCol) {
            blocked_down = true;
        }
    }

    bool blocked_left = false;
    for (int i = rookCol - 1; i >= 1; i--) {
        if (rookRow == queenRow && i == queenCol) {
            if (!blocked_left) {
                int current_dist = rookCol - i;
                rook_moves = (rook_moves == INT_MAX) ? current_dist : (current_dist < rook_moves ? current_dist : rook_moves);
            }
            break;
        }
        if (rookRow == bishopRow && i == bishopCol) {
            blocked_left = true;
        }
    }

    bool blocked_right = false;
    for (int i = rookCol + 1; i <= 8; i++) {
        if (rookRow == queenRow && i == queenCol) {
            if (!blocked_right) {
                int current_dist = i - rookCol;
                rook_moves = (rook_moves == INT_MAX) ? current_dist : (current_dist < rook_moves ? current_dist : rook_moves);
            }
            break;
        }
        if (rookRow == bishopRow && i == bishopCol) {
            blocked_right = true;
        }
    }

    // Bishop moves
    bool blocked_up_right = false;
    for (int i = bishopRow - 1, j = bishopCol + 1; i >= 1 && j <= 8; i--, j++) {
        if (i == queenRow && j == queenCol) {
            if (!blocked_up_right) {
                bishop_moves = bishopRow - queenRow;
            }
            break;
        }
        if (i == rookRow && j == rookCol) {
            blocked_up_right = true;
        }
    }

    bool blocked_up_left = false;
    for (int i = bishopRow - 1, j = bishopCol - 1; i >= 1 && j >= 1; i--, j--) {
        if (i == queenRow && j == queenCol) {
            if (!blocked_up_left) {
                int current_dist = bishopRow - queenRow;
                bishop_moves = (bishop_moves == INT_MAX) ? current_dist : (current_dist < bishop_moves ? current_dist : bishop_moves);
            }
            break;
        }
        if (i == rookRow && j == rookCol) {
            blocked_up_left = true;
        }
    }

    bool blocked_down_right = false;
    for (int i = bishopRow + 1, j = bishopCol + 1; i <= 8 && j <= 8; i++, j++) {
        if (i == queenRow && j == queenCol) {
            if (!blocked_down_right) {
                int current_dist = i - bishopRow;
                bishop_moves = (bishop_moves == INT_MAX) ? current_dist : (current_dist < bishop_moves ? current_dist : bishop_moves);
            }
            break;
        }
        if (i == rookRow && j == rookCol) {
            blocked_down_right = true;
        }
    }

    bool blocked_down_left = false;
    for (int i = bishopRow + 1, j = bishopCol - 1; i <= 8 && j >= 1; i++, j--) {
        if (i == queenRow && j == queenCol) {
            if (!blocked_down_left) {
                int current_dist = i - bishopRow;
                bishop_moves = (bishop_moves == INT_MAX) ? current_dist : (current_dist < bishop_moves ? current_dist : bishop_moves);
            }
            break;
        }
        if (i == rookRow && j == rookCol) {
            blocked_down_left = true;
        }
    }

    if (rook_moves == INT_MAX && bishop_moves == INT_MAX) return 2;
    if (rook_moves == INT_MAX) return 1;
    if (bishop_moves == INT_MAX) return 1;

    return (rook_moves < bishop_moves) ? 1 : 1;
}