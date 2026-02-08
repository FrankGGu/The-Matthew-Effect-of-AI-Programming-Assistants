import java.math.BigInteger;

class Solution {
    public long maxProductPath(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        BigInteger[][] dpMax = new BigInteger[m][n];
        BigInteger[][] dpMin = new BigInteger[m][n];

        BigInteger MOD = BigInteger.valueOf(1_000_000_007);

        dpMax[0][0] = BigInteger.valueOf(grid[0][0]);
        dpMin[0][0] = BigInteger.valueOf(grid[0][0]);

        for (int j = 1; j < n; j++) {
            BigInteger val = BigInteger.valueOf(grid[0][j]);
            if (val.compareTo(BigInteger.ZERO) >= 0) {
                dpMax[0][j] = dpMax[0][j - 1].multiply(val);
                dpMin[0][j] = dpMin[0][j - 1].multiply(val);
            } else {
                dpMax[0][j] = dpMin[0][j - 1].multiply(val);
                dpMin[0][j] = dpMax[0][j - 1].multiply(val);
            }
        }

        for (int i = 1; i < m; i++) {
            BigInteger val = BigInteger.valueOf(grid[i][0]);
            if (val.compareTo(BigInteger.ZERO) >= 0) {
                dpMax[i][0] = dpMax[i - 1][0].multiply(val);
                dpMin[i][0] = dpMin[i - 1][0].multiply(val);
            } else {
                dpMax[i][0] = dpMin[i - 1][0].multiply(val);
                dpMin[i][0] = dpMax[i - 1][0].multiply(val);
            }
        }

        for (int i = 1; i < m; i++) {
            for (int j = 1; j < n; j++) {
                BigInteger val = BigInteger.valueOf(grid[i][j]);
                if (val.compareTo(BigInteger.ZERO) >= 0) {
                    dpMax[i][j] = dpMax[i - 1][j].multiply(val).max(dpMax[i][j - 1].multiply(val));
                    dpMin[i][j] = dpMin[i - 1][j].multiply(val).min(dpMin[i][j - 1].multiply(val));
                } else {
                    dpMax[i][j] = dpMin[i - 1][j].multiply(val).max(dpMin[i][j - 1].multiply(val));
                    dpMin[i][j] = dpMax[i - 1][j].multiply(val).min(dpMax[i][j - 1].multiply(val));
                }
            }
        }

        BigInteger result = dpMax[m - 1][n - 1];
        if (result.compareTo(BigInteger.ZERO) < 0) {
            return -1;
        } else {
            return result.mod(MOD).longValue();
        }
    }
}