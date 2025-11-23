#include <stdlib.h> // For abs

int minMovesToCaptureTheQueen(int a, int b, int c, int d, int e, int f) {
    // Check if Rook can capture the Queen in 1 move
    // Rook is at (a, b), Queen at (e, f), Bishop at (c, d)

    // Case 1: Rook and Queen are on the same row
    if (a == e) {
        // Check if the Bishop is blocking the Rook's path
        // The Bishop blocks if it's on the same row as the Rook and Queen (c == a)
        // AND its column is strictly between the Rook's and Queen's columns
        if (c == a && ((b < d && d < f) || (f < d && d < b))) {
            // Bishop is blocking, Rook cannot capture in 1 move along this row
        } else {
            // Rook can capture in 1 move
            return 1;
        }
    }

    // Case 2: Rook and Queen are on the same column
    if (b == f) {
        // Check if the Bishop is blocking the Rook's path
        // The Bishop blocks if it's on the same column as the Rook and Queen (d == b)
        // AND its row is strictly between the Rook's and Queen's rows
        if (d == b && ((a < c && c < e) || (e < c && c < a))) {
            // Bishop is blocking, Rook cannot capture in 1 move along this column
        } else {
            // Rook can capture in 1 move
            return 1;
        }
    }

    // Check if Bishop can capture the Queen in 1 move
    // Bishop is at (c, d), Queen at (e, f), Rook at (a, b)

    // Bishop and Queen must be on the same diagonal
    if (abs(c - e) == abs(d - f)) {
        // Check if the Rook is blocking the Bishop's path
        // The Rook blocks if it's on the same diagonal line as the Bishop and Queen
        // AND its position is strictly between the Bishop's and Queen's positions

        // Condition for Rook being on the same diagonal line as Bishop and Queen:
        // abs(a - c) == abs(b - d) implies Rook and Bishop are on the same diagonal
        // AND
        // abs(a - e) == abs(b - f) implies Rook and Queen are on the same diagonal
        if (abs(a - c) == abs(b - d) && abs(a - e) == abs(b - f)) {
            // Condition for Rook being strictly between Bishop and Queen:
            // This means Rook's row (a) must be strictly between Bishop's row (c) and Queen's row (e)
            // (Since they are on a diagonal, if 'a' is between 'c' and 'e', then 'b' will also be between 'd' and 'f')
            if ((a > c && a < e) || (a < c && a > e)) {
                // Rook is blocking, Bishop cannot capture in 1 move
            } else {
                // Rook is on the same diagonal but not between (e.g., Rook-Bishop-Queen or Bishop-Queen-Rook),
                // so Bishop can capture in 1 move
                return 1;
            }
        } else {
            // Rook is not on the same diagonal line as Bishop and Queen, so it cannot block
            // Bishop can capture in 1 move
            return 1;
        }
    }

    // If neither the Rook nor the Bishop can capture the Queen in 1 move,
    // then it will always take 2 moves.
    return 2;
}