public class Solution {
    public int totalNQueens(int n) {
        boolean[] cols = new boolean[n];
        boolean[] diag1 = new boolean[2 * n - 1];
        boolean[] diag2 = new boolean[2 * n - 1];
        return backtrack(0, cols, diag1, diag2, n);
    }

    private int backtrack(int row, boolean[] cols, boolean[] diag1, boolean[] diag2, int n) {
        if (row == n) return 1;
        int count = 0;
        for (int col = 0; col < n; col++) {
            int d1 = row + col;
            int d2 = row - col + n - 1;
            if (!cols[col] && !diag1[d1] && !diag2[d2]) {
                cols[col] = true;
                diag1[d1] = true;
                diag2[d2] = true;
                count += backtrack(row + 1, cols, diag1, diag2, n);
                cols[col] = false;
                diag1[d1] = false;
                diag2[d2] = false;
            }
        }
        return count;
    }
}