class Solution {
    public long gridGame(int[][] grid) {
        int n = grid[0].length;
        long[] prefix1 = new long[n];
        long[] prefix2 = new long[n];

        prefix1[0] = grid[0][0];
        for (int i = 1; i < n; i++) {
            prefix1[i] = prefix1[i - 1] + grid[0][i];
        }

        prefix2[0] = grid[1][0];
        for (int i = 1; i < n; i++) {
            prefix2[i] = prefix2[i - 1] + grid[1][i];
        }

        long res = Long.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            long option1 = i == n - 1 ? 0 : prefix1[n - 1] - prefix1[i];
            long option2 = i == 0 ? 0 : prefix2[i - 1];
            res = Math.min(res, Math.max(option1, option2));
        }

        return res;
    }
}