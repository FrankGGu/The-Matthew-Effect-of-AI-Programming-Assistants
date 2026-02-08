public class Solution {
    public long gridGame(int[][] grid) {
        int n = grid.length;
        long[] top = new long[n];
        long[] bottom = new long[n];

        for (int i = 0; i < n; i++) {
            top[i] = grid[0][i];
            bottom[i] = grid[1][i];
        }

        for (int i = 1; i < n; i++) {
            top[i] += top[i - 1];
            bottom[i] += bottom[i - 1];
        }

        long min = Long.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            long upper = top[n - 1] - top[i];
            long lower = bottom[i];
            min = Math.min(min, Math.max(upper, lower));
        }

        return min;
    }
}