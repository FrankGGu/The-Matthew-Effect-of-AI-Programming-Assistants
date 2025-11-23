class Solution {
    public boolean canCutGrid(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[] rowSum = new int[m];
        int[] colSum = new int[n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                rowSum[i] += grid[i][j];
                colSum[j] += grid[i][j];
            }
        }

        int totalSum = 0;
        for (int sum : rowSum) totalSum += sum;

        if (totalSum % (m * n) != 0) return false;

        int targetSum = totalSum / (m * n);
        for (int sum : rowSum) {
            if (sum % n != 0) return false;
        }

        for (int sum : colSum) {
            if (sum % m != 0) return false;
        }

        return true;
    }
}