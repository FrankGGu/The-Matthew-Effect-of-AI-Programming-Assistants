class Solution {
    public int movesToChessboard(int[][] board) {
        int n = board.length;
        int rowMask = 0;
        for (int i = 0; i < n; i++) {
            rowMask |= (board[0][i] << i);
        }

        int mask = (1 << n) - 1;
        int rowInverse = rowMask ^ mask;
        int rowCount = 0, rowInverseCount = 0;
        for (int i = 0; i < n; i++) {
            int currMask = 0;
            for (int j = 0; j < n; j++) {
                currMask |= (board[i][j] << j);
            }
            if (currMask != rowMask && currMask != rowInverse) {
                return -1;
            }
            if (currMask == rowMask) {
                rowCount++;
            } else {
                rowInverseCount++;
            }
        }

        if (Math.abs(rowCount - rowInverseCount) > 1) {
            return -1;
        }

        int colMask = 0;
        for (int i = 0; i < n; i++) {
            colMask |= (board[i][0] << i);
        }

        int colInverse = colMask ^ mask;
        int colCount = 0, colInverseCount = 0;
        for (int i = 0; i < n; i++) {
            int currMask = 0;
            for (int j = 0; j < n; j++) {
                currMask |= (board[j][i] << j);
            }
            if (currMask != colMask && currMask != colInverse) {
                return -1;
            }
            if (currMask == colMask) {
                colCount++;
            } else {
                colInverseCount++;
            }
        }

        if (Math.abs(colCount - colInverseCount) > 1) {
            return -1;
        }

        int rowMoves = Integer.MAX_VALUE;
        if (rowCount >= rowInverseCount) {
            int ones = 0;
            for (int i = 0; i < n; i++) {
                if ((rowMask & (1 << i)) != (i % 2 == 0 ? 1 : 0)) {
                    ones++;
                }
            }
            rowMoves = Math.min(rowMoves, ones / 2);
        } else {
            int ones = 0;
            for (int i = 0; i < n; i++) {
                if ((rowInverse & (1 << i)) != (i % 2 == 0 ? 1 : 0)) {
                    ones++;
                }
            }
            rowMoves = Math.min(rowMoves, ones / 2);
        }

        int colMoves = Integer.MAX_VALUE;
        if (colCount >= colInverseCount) {
            int ones = 0;
            for (int i = 0; i < n; i++) {
                if ((colMask & (1 << i)) != (i % 2 == 0 ? 1 : 0)) {
                    ones++;
                }
            }
            colMoves = Math.min(colMoves, ones / 2);
        } else {
            int ones = 0;
            for (int i = 0; i < n; i++) {
                if ((colInverse & (1 << i)) != (i % 2 == 0 ? 1 : 0)) {
                    ones++;
                }
            }
            colMoves = Math.min(colMoves, ones / 2);
        }

        return rowMoves + colMoves;
    }
}