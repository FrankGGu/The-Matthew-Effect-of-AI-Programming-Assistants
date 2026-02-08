public class Solution {
    public int maxSideLength(int[][] grid, int threshold) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] prefix = new int[m + 1][n + 1];

        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                prefix[i][j] = grid[i - 1][j - 1] + prefix[i - 1][j] + prefix[i][j - 1] - prefix[i - 1][j - 1];
            }
        }

        int left = 1;
        int right = Math.min(m, n);
        int result = 0;

        while (left <= right) {
            int mid = (left + right) / 2;
            boolean found = false;

            for (int i = mid; i <= m; i++) {
                for (int j = mid; j <= n; j++) {
                    int sum = prefix[i][j] - prefix[i - mid][j] - prefix[i][j - mid] + prefix[i - mid][j - mid];
                    if (sum <= threshold) {
                        found = true;
                        break;
                    }
                }
                if (found) break;
            }

            if (found) {
                result = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return result;
    }
}