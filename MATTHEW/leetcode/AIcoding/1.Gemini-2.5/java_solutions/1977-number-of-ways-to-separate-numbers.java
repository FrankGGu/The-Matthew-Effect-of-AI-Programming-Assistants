import java.util.Arrays;

class Solution {
    private int n;
    private String num;
    private int[][] lcp;
    private final int MOD = 1_000_000_007;

    private boolean is_le(int s1_idx, int s2_idx, int len) {
        int common_len = lcp[s1_idx][s2_idx];
        if (common_len >= len) {
            return true;
        }
        return num.charAt(s1_idx + common_len) < num.charAt(s2_idx + common_len);
    }

    public int numberOfWays(String numStr) {
        this.num = numStr;
        this.n = num.length();

        lcp = new int[n + 1][n + 1];
        for (int i = n - 1; i >= 0; i--) {
            for (int j = n - 1; j >= 0; j--) {
                if (num.charAt(i) == num.charAt(j)) {
                    lcp[i][j] = 1 + lcp[i + 1][j + 1];
                } else {
                    lcp[i][j] = 0;
                }
            }
        }

        int[][] dp = new int[n + 1][n + 1];
        int[][] prefix_sum = new int[n + 1][n + 1];

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= i; j++) {
                int curr_start_idx = i - j;

                if (num.charAt(curr_start_idx) == '0' && j > 1) {
                    dp[i][j] = 0;
                } else {
                    if (curr_start_idx == 0) {
                        dp[i][j] = 1;
                    } else {
                        dp[i][j] = prefix_sum[curr_start_idx][Math.min(j - 1, curr_start_idx)];

                        if (j <= curr_start_idx) {
                            int prev_start_idx = curr_start_idx - j;
                            if (is_le(prev_start_idx, curr_start_idx, j)) {
                                dp[i][j] = (dp[i][j] + dp[curr_start_idx][j]) % MOD;
                            }
                        }
                    }
                }
                prefix_sum[i][j] = (prefix_sum[i][j - 1] + dp[i][j]) % MOD;
            }
        }

        return prefix_sum[n][n];
    }
}