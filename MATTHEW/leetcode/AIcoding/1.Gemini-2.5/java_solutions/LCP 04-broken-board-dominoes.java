import java.util.Arrays;

class Solution {
    int M;
    int N;
    boolean[][] isBroken;
    long[][] dp;

    public long dominoTiling(int m, int n, int[][] broken) {
        M = m;
        N = n;
        isBroken = new boolean[M][N];
        for (int[] cell : broken) {
            isBroken[cell[0]][cell[1]] = true;
        }

        dp = new long[N + 1][1 << M];
        dp[0][0] = 1;

        for (int col = 0; col < N; col++) {
            for (int currentMask = 0; currentMask < (1 << M); currentMask++) {
                if (dp[col][currentMask] == 0) {
                    continue;
                }
                fill(col, 0, currentMask, 0);
            }
        }

        return dp[N][0];
    }

    private void fill(int col, int row, int currentMask, int nextMask) {
        if (row == M) {
            dp[col + 1][nextMask] += dp[col][currentMask];
            return;
        }

        if (isBroken[row][col]) {
            if (((currentMask >> row) & 1) == 1) {
                return;
            }
            fill(col, row + 1, currentMask, nextMask);
            return;
        }

        if (((currentMask >> row) & 1) == 1) {
            fill(col, row + 1, currentMask, nextMask);
            return;
        }

        if (row + 1 < M && !isBroken[row + 1][col] && (((currentMask >> (row + 1)) & 1) == 0)) {
            fill(col, row + 2, currentMask, nextMask);
        }

        if (col + 1 < N && !isBroken[row][col + 1]) {
            fill(col, row + 1, currentMask, nextMask | (1 << row));
        }
    }
}