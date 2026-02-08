class Solution {
    public int minimumOperationsToWriteY(int[][] grid) {
        int n = grid.length;
        int one = n / 2;
        int zero = n * n - 2 * one - 1;
        int[] countOne = new int[3];
        int[] countZero = new int[3];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (isY(i, j, n)) {
                    countOne[grid[i][j]]++;
                } else {
                    countZero[grid[i][j]]++;
                }
            }
        }

        int ans = Integer.MAX_VALUE;
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                if (i != j) {
                    ans = Math.min(ans, one - countOne[i] + zero - countZero[j]);
                }
            }
        }

        return ans;
    }

    private boolean isY(int i, int j, int n) {
        int one = n / 2;
        if (j == i && i < one) return true;
        if (j == n - 1 - i && i < one) return true;
        if (j == one && i >= one) return true;
        return false;
    }
}