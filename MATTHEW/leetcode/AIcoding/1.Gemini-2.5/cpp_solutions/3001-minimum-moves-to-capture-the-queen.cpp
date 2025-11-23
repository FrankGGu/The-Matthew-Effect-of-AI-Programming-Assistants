#include <cmath>   // For abs
#include <algorithm> // For std::min, std::max

class Solution {
public:
    int minMovesToCaptureTheQueen(int r1, int c1, int b1, int b2, int q1, int q2) {
        // Check if Rook can capture the Queen in 1 move
        bool rook_can_capture = false;
        if (r1 == q1) { // Same row
            if (b1 == r1 && ((c1 < b2 && b2 < q2) || (q2 < b2 && b2 < c1))) {
                // Bishop is on the same row and between Rook and Queen, blocking the Rook.
            } else {
                rook_can_capture = true;
            }
        } else if (c1 == q2) { // Same column
            if (b2 == c1 && ((r1 < b1 && b1 < q1) || (q1 < b1 && b1 < r1))) {
                // Bishop is on the same column and between Rook and Queen, blocking the Rook.
            } else {
                rook_can_capture = true;
            }
        }

        if (rook_can_capture) {
            return 1;
        }

        // Check if Bishop can capture the Queen in 1 move
        bool bishop_can_capture = false;
        if (std::abs(b1 - q1) == std::abs(b2 - q2)) { // Bishop and Queen are on the same diagonal
            // Check if Rook is on the same diagonal and between Bishop and Queen
            // Rook is on the same diagonal as Bishop and Queen if:
            // 1. Rook and Bishop are on the same diagonal: abs(r1 - b1) == abs(c1 - b2)
            // 2. Rook and Queen are on the same diagonal: abs(r1 - q1) == abs(c1 - q2)
            // If both are true, and B-Q are on a diagonal, then R, B, Q are collinear on a diagonal.
            bool rook_on_same_diagonal_as_bq = (std::abs(r1 - b1) == std::abs(c1 - b2)) &&
                                                (std::abs(r1 - q1) == std::abs(c1 - q2));

            // Rook is strictly between Bishop and Queen if its row (or column) is between theirs
            bool rook_is_between_bq = (r1 > std::min(b1, q1) && r1 < std::max(b1, q1));

            if (rook_on_same_diagonal_as_bq && rook_is_between_bq) {
                // Rook is on the same diagonal and between Bishop and Queen, blocking the Bishop.
            } else {
                bishop_can_capture = true;
            }
        }

        if (bishop_can_capture) {
            return 1;
        }

        // If neither can capture in 1 move, it takes 2 moves.
        return 2;
    }
};