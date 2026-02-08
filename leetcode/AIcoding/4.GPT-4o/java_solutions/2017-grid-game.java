class Solution {
    public long gridGame(int[][] grid) {
        int n = grid[0].length;
        long[] prefixSum = new long[n + 1];

        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + grid[0][i];
        }

        long totalSum = prefixSum[n];
        long minPathSum = Long.MAX_VALUE;
        long topSum = 0;

        for (int i = 0; i < n; i++) {
            topSum += grid[1][i];
            long bottomSum = totalSum - prefixSum[i + 1];
            minPathSum = Math.min(minPathSum, Math.max(topSum, bottomSum));
        }

        return minPathSum;
    }
}