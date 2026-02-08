class Solution {
    public int maxStudents(char[][] seats) {
        int m = seats.length;
        int n = seats[0].length;
        int[] rows = new int[m];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (seats[i][j] == '.') {
                    rows[i] |= (1 << j);
                }
            }
        }

        int[][] dp = new int[m][1 << n];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < (1 << n); j++) {
                dp[i][j] = -1;
            }
        }

        return solve(rows, 0, 0, dp, n);
    }

    private int solve(int[] rows, int row, int prevMask, int[][] dp, int n) {
        if (row == rows.length) {
            return 0;
        }

        if (dp[row][prevMask] != -1) {
            return dp[row][prevMask];
        }

        int maxStudents = 0;
        for (int mask = 0; mask < (1 << n); mask++) {
            if ((mask & rows[row]) == mask) {
                boolean valid = true;
                for (int j = 0; j < n; j++) {
                    if ((mask & (1 << j)) != 0) {
                        if ((j > 0 && (mask & (1 << (j - 1))) != 0) ||
                            (j < n - 1 && (mask & (1 << (j + 1))) != 0)) {
                            valid = false;
                            break;
                        }
                    }
                }

                if (valid) {
                    for (int j = 0; j < n; j++) {
                        if ((mask & (1 << j)) != 0) {
                            if ((j > 0 && (prevMask & (1 << (j - 1))) != 0) ||
                                (j < n - 1 && (prevMask & (1 << (j + 1))) != 0)) {
                                valid = false;
                                break;
                            }
                        }
                    }
                }

                if (valid) {
                    int count = Integer.bitCount(mask);
                    maxStudents = Math.max(maxStudents, count + solve(rows, row + 1, mask, dp, n));
                }
            }
        }

        return dp[row][prevMask] = maxStudents;
    }
}