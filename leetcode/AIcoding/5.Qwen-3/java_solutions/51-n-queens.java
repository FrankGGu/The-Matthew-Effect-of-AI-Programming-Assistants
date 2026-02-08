public class Solution {

import java.util.*;

public class Solution {
    public List<List<String>> solveNQueens(int n) {
        List<List<String>> result = new ArrayList<>();
        int[] queens = new int[n];
        Arrays.fill(queens, -1);
        solveNQueensHelper(queens, 0, result);
        return result;
    }

    private void solveNQueensHelper(int[] queens, int row, List<List<String>> result) {
        if (row == queens.length) {
            result.add(generateBoard(queens));
            return;
        }
        for (int col = 0; col < queens.length; col++) {
            if (isValid(queens, row, col)) {
                queens[row] = col;
                solveNQueensHelper(queens, row + 1, result);
                queens[row] = -1;
            }
        }
    }

    private boolean isValid(int[] queens, int row, int col) {
        for (int i = 0; i < row; i++) {
            int qCol = queens[i];
            if (qCol == col || Math.abs(i - row) == Math.abs(qCol - col)) {
                return false;
            }
        }
        return true;
    }

    private List<String> generateBoard(int[] queens) {
        List<String> board = new ArrayList<>();
        for (int col : queens) {
            StringBuilder row = new StringBuilder();
            for (int i = 0; i < queens.length; i++) {
                row.append(i == col ? 'Q' : '.');
            }
            board.add(row.toString());
        }
        return board;
    }
}
}