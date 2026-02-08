class Solution {
    private static final int MOD = 1_000_000_007;
    private int R, C;
    private int[][] apples;
    private int[][][] dp;

    public int ways(String[] pizza, int k) {
        R = pizza.length;
        C = pizza[0].length();

        apples = new int[R + 1][C + 1];
        // Precompute suffix sums for apples
        // apples[r][c] stores the number of apples in the rectangle from (r, c) to (R-1, C-1)
        for (int r = R - 1; r >= 0; r--) {
            for (int c = C - 1; c >= 0; c--) {
                apples[r][c] = (pizza[r].charAt(c) == 'A' ? 1 : 0);
                apples[r][c] += apples[r + 1][c];
                apples[r][c] += apples[r][c + 1];
                apples[r][c] -= apples[r + 1][c + 1];
            }
        }

        dp = new int[k + 1][R + 1][C + 1];

        // Base case: k = 1 (1 piece, 0 cuts)
        // dp[1][r][c] = 1 if the sub-pizza (r,c) to (R-1,C-1) has at least one apple, else 0.
        for (int r = 0; r < R; r++) {
            for (int c = 0; c < C; c++) {
                if (hasApple(r, c, R - 1, C - 1)) {
                    dp[1][r][c] = 1;
                }
            }
        }

        // Fill DP table for k from 2 to K
        // dp[k][r][c] = number of ways to cut the sub-pizza (r,c) to (R-1,C-1) into k pieces.
        for (int cuts = 2; cuts <= k; cuts++) {
            for (int r = R - 1; r >= 0; r--) {
                for (int c = C - 1; c >= 0; c--) {
                    // If the current sub-pizza has no apples, it cannot be cut further or be a final piece.
                    if (!hasApple(r, c, R - 1, C - 1)) {
                        continue;
                    }

                    // Try all possible horizontal cuts
                    // Cut at row nextR. Top piece is (r,c) to (nextR-1, C-1).
                    // Bottom piece is (nextR, c) to (R-1, C-1).
                    // The top piece is "finished" and must have an apple.
                    // The bottom piece is "chosen" to be cut into (cuts-1) pieces.
                    for (int nextR = r + 1; nextR < R; nextR++) {
                        if (hasApple(r, c, nextR - 1, C - 1)) { // If the top piece has an apple
                            dp[cuts][r][c] = (dp[cuts][r][c] + dp[cuts - 1][nextR][c]) % MOD;
                        }
                    }

                    // Try all possible vertical cuts
                    // Cut at col nextC. Left piece is (r,c) to (R-1, nextC-1).
                    // Right piece is (r, nextC) to (R-1, C-1).
                    // The left piece is "finished" and must have an apple.
                    // The right piece is "chosen" to be cut into (cuts-1) pieces.
                    for (int nextC = c + 1; nextC < C; nextC++) {
                        if (hasApple(r, c, R - 1, nextC - 1)) { // If the left piece has an apple
                            dp[cuts][r][c] = (dp[cuts][r][c] + dp[cuts - 1][r][nextC]) % MOD;
                        }
                    }
                }
            }
        }

        return dp[k][0][0];
    }

    // Helper function to check if a rectangle (r1, c1) to (r2, c2) contains at least one apple.
    private boolean hasApple(int r1, int c1, int r2, int c2) {
        // Using the precomputed suffix sums
        // apples[r1][c1] - apples[r2+1][c1] - apples[r1][c2+1] + apples[r2+1][c2+1]
        return (apples[r1][c1] - apples[r2 + 1][c1] - apples[r1][c2 + 1] + apples[r2 + 1][c2 + 1]) > 0;
    }
}