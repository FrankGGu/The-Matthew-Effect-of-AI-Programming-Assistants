class Solution {
    public boolean canCutIntoSections(int[][] grid, int r, int c) {
        int m = grid.length;
        int n = grid[0].length;

        if (m % r != 0 || n % c != 0) {
            return false;
        }

        int[][] prefixSum = new int[m + 1][n + 1];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                prefixSum[i + 1][j + 1] = grid[i][j] + prefixSum[i][j + 1] + prefixSum[i + 1][j] - prefixSum[i][j];
            }
        }

        for (int i = 0; i < m; i += r) {
            for (int j = 0; j < n; j += c) {
                int currentBlockSum = prefixSum[i + r][j + c] - prefixSum[i][j + c] - prefixSum[i + r][j] + prefixSum[i][j];

                if (currentBlockSum != r * c) {
                    return false;
                }
            }
        }

        return true;
    }
}