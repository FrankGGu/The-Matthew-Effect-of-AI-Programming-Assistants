public class Solution {
    public int movesToChessboard(int[][] board) {
        int n = board.length;
        int rowCount = 0, colCount = 0, rowSwap = 0, colSwap = 0;

        for (int i = 0; i < n; i++) {
            rowCount += board[0][i];
            colCount += board[i][0];
        }

        if (rowCount != n / 2 && rowCount != (n + 1) / 2) return -1;
        if (colCount != n / 2 && colCount != (n + 1) / 2) return -1;

        for (int i = 0; i < n; i++) {
            if (board[i][0] == (i % 2)) rowSwap++;
            if (board[0][i] == (i % 2)) colSwap++;
        }

        if (n % 2 == 0) {
            if (rowSwap % 2 == 1) rowSwap = n - rowSwap;
            if (colSwap % 2 == 1) colSwap = n - colSwap;
        } else {
            rowSwap = Math.min(rowSwap, n - rowSwap);
            colSwap = Math.min(colSwap, n - colSwap);
        }

        return (rowSwap + colSwap) / 2;
    }
}