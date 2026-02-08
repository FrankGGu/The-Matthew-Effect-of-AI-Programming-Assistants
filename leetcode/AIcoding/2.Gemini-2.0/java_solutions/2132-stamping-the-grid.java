class Solution {
    public boolean possibleToStamp(int[][] grid, int stampHeight, int stampWidth) {
        int m = grid.length;
        int n = grid[0].length;

        int[][] prefixSum = new int[m + 1][n + 1];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                prefixSum[i + 1][j + 1] = prefixSum[i + 1][j] + prefixSum[i][j + 1] - prefixSum[i][j] + grid[i][j];
            }
        }

        int[][] stampCount = new int[m][n];
        for (int i = 0; i <= m - stampHeight; i++) {
            for (int j = 0; j <= n - stampWidth; j++) {
                int sum = prefixSum[i + stampHeight][j + stampWidth] - prefixSum[i + stampHeight][j] - prefixSum[i][j + stampWidth] + prefixSum[i][j];
                if (sum == 0) {
                    stampCount[i][j]++;
                    if (i + stampHeight < m) stampCount[i + stampHeight][j]--;
                    if (j + stampWidth < n) stampCount[i][j + stampWidth]--;
                    if (i + stampHeight < m && j + stampWidth < n) stampCount[i + stampHeight][j + stampWidth]++;
                }
            }
        }

        int[][] stampPrefixSum = new int[m + 1][n + 1];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                stampPrefixSum[i + 1][j + 1] = stampPrefixSum[i + 1][j] + stampPrefixSum[i][j + 1] - stampPrefixSum[i][j] + stampCount[i][j];
            }
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 0) {
                    if (stampPrefixSum[i + 1][j + 1] - (i > 0 ? stampPrefixSum[i][j + 1] : 0) - (j > 0 ? stampPrefixSum[i + 1][j] : 0) + (i > 0 && j > 0 ? stampPrefixSum[i][j] : 0) == 0) {
                        return false;
                    }
                }
            }
        }

        return true;
    }
}