class Solution {
    private int count = 0;
    private boolean[] cols;
    private boolean[] diag1; // i + j
    private boolean[] diag2; // i - j + n - 1

    public int totalNQueens(int n) {
        cols = new boolean[n];
        diag1 = new boolean[2 * n - 1];
        diag2 = new boolean[2 * n - 1];

        backtrack(0, n);
        return count;
    }

    private void backtrack(int row, int n) {
        if (row == n) {
            count++;
            return;
        }

        for (int col = 0; col < n; col++) {
            if (!cols[col] && !diag1[row + col] && !diag2[row - col + n - 1]) {
                cols[col] = true;
                diag1[row + col] = true;
                diag2[row - col + n - 1] = true;

                backtrack(row + 1, n);

                cols[col] = false;
                diag1[row + col] = false;
                diag2[row - col + n - 1] = false;
            }
        }
    }
}