import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Solution {
    public List<List<String>> solveNQueens(int n) {
        List<List<String>> result = new ArrayList<>();
        char[][] board = new char[n][n];
        for (int i = 0; i < n; i++) {
            Arrays.fill(board[i], '.');
        }

        boolean[] cols = new boolean[n];
        boolean[] diag1 = new boolean[2 * n - 1]; // For r - c + n - 1
        boolean[] diag2 = new boolean[2 * n - 1]; // For r + c

        backtrack(0, n, board, result, cols, diag1, diag2);

        return result;
    }

    private void backtrack(int row, int n, char[][] board, List<List<String>> result,
                           boolean[] cols, boolean[] diag1, boolean[] diag2) {
        if (row == n) {
            List<String> currentSolution = new ArrayList<>();
            for (int i = 0; i < n; i++) {
                currentSolution.add(new String(board[i]));
            }
            result.add(currentSolution);
            return;
        }

        for (int col = 0; col < n; col++) {
            int diag1Idx = row - col + n - 1;
            int diag2Idx = row + col;

            if (!cols[col] && !diag1[diag1Idx] && !diag2[diag2Idx]) {
                board[row][col] = 'Q';
                cols[col] = true;
                diag1[diag1Idx] = true;
                diag2[diag2Idx] = true;

                backtrack(row + 1, n, board, result, cols, diag1, diag2);

                board[row][col] = '.';
                cols[col] = false;
                diag1[diag1Idx] = false;
                diag2[diag2Idx] = false;
            }
        }
    }
}