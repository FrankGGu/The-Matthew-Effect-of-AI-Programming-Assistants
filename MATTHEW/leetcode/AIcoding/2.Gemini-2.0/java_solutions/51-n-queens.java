import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<List<String>> solveNQueens(int n) {
        List<List<String>> result = new ArrayList<>();
        int[] queens = new int[n];
        solveNQueensHelper(result, queens, 0, n);
        return result;
    }

    private void solveNQueensHelper(List<List<String>> result, int[] queens, int row, int n) {
        if (row == n) {
            List<String> board = new ArrayList<>();
            for (int i = 0; i < n; i++) {
                StringBuilder sb = new StringBuilder();
                for (int j = 0; j < n; j++) {
                    if (queens[i] == j) {
                        sb.append('Q');
                    } else {
                        sb.append('.');
                    }
                }
                board.add(sb.toString());
            }
            result.add(board);
            return;
        }

        for (int col = 0; col < n; col++) {
            if (isValid(queens, row, col)) {
                queens[row] = col;
                solveNQueensHelper(result, queens, row + 1, n);
            }
        }
    }

    private boolean isValid(int[] queens, int row, int col) {
        for (int i = 0; i < row; i++) {
            if (queens[i] == col || Math.abs(queens[i] - col) == row - i) {
                return false;
            }
        }
        return true;
    }
}