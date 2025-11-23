class Solution {
    public int minMoves(int n, int m, int row, int col, int rMove, int cMove) {
        int moves = 0;
        while (row != n && col != m && row != 1 && col != 1) {
            if (rMove == 0 && cMove == 0) {
                break;
            }

            if (rMove != 0 && (row + rMove > n || row + rMove < 1)) {
                rMove = -rMove;
            }

            if (cMove != 0 && (col + cMove > m || col + cMove < 1)) {
                cMove = -cMove;
            }

            if (rMove == 0 && cMove == 0) break;

            row += rMove;
            col += cMove;
            moves++;
        }
        return moves;
    }
}