class Solution {
    public long[] maxPoints(int[][] grid, int[][] queries) {
        int m = grid.length, n = grid[0].length;
        long[][] prefix = new long[m + 1][n + 1];

        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                prefix[i][j] = grid[i - 1][j - 1] + prefix[i - 1][j] + prefix[i][j - 1] - prefix[i - 1][j - 1];
            }
        }

        long[] result = new long[queries.length];
        int[][] sortedQueries = new int[queries.length][3];
        for (int i = 0; i < queries.length; i++) {
            sortedQueries[i][0] = queries[i][0];
            sortedQueries[i][1] = queries[i][1];
            sortedQueries[i][2] = i;
        }
        Arrays.sort(sortedQueries, (a, b) -> Long.compare(b[0], a[0]));

        long maxPoints = 0;
        for (int[] query : sortedQueries) {
            int x = query[0], y = query[1], index = query[2];
            maxPoints = Math.max(maxPoints, getMaxPoints(prefix, x, y));
            result[index] = maxPoints;
        }

        return result;
    }

    private long getMaxPoints(long[][] prefix, int x, int y) {
        int m = prefix.length - 1;
        int n = prefix[0].length - 1;
        long max = 0;
        for (int i = 1; i <= m && i <= x; i++) {
            for (int j = 1; j <= n && j <= y; j++) {
                max = Math.max(max, prefix[i][j]);
            }
        }
        return max;
    }
}