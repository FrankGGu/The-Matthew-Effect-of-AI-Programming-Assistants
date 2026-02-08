import java.util.Arrays;

class Solution {
    public int minimumDivisionOperations(int[] nums, int[] divisors) {
        int n = nums.length;
        int m = divisors.length;

        int[] target = Arrays.copyOf(nums, n);
        for (int i = 1; i < n; i++) {
            target[i] = Math.max(target[i], target[i - 1]);
        }

        int[][][] dp = new int[n + 1][m + 1][2];
        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= m; j++) {
                Arrays.fill(dp[i][j], Integer.MAX_VALUE / 2);
            }
        }

        dp[0][0][0] = 0;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j <= m; j++) {
                for (int k = 0; k < 2; k++) {
                    if (dp[i][j][k] == Integer.MAX_VALUE / 2) continue;

                    if (k == 0) {
                        if (nums[i] <= (i > 0 ? target[i - 1] : Integer.MIN_VALUE)) {
                            dp[i + 1][j][0] = Math.min(dp[i + 1][j][0], dp[i][j][0]);
                        } else {
                            dp[i + 1][j][1] = Math.min(dp[i + 1][j][1], dp[i][j][0]);
                        }

                        if (j < m) {
                            int newNum = nums[i] / divisors[j];
                            if (newNum <= (i > 0 ? target[i - 1] : Integer.MIN_VALUE)) {
                                dp[i + 1][j + 1][0] = Math.min(dp[i + 1][j + 1][0], dp[i][j][0] + 1);
                            } else {
                                dp[i + 1][j + 1][1] = Math.min(dp[i + 1][j + 1][1], dp[i][j][0] + 1);
                            }
                        }
                    } else {
                        dp[i + 1][j][1] = Math.min(dp[i + 1][j][1], dp[i][j][1]);
                        if (j < m) {
                            int newNum = nums[i] / divisors[j];
                            dp[i + 1][j + 1][1] = Math.min(dp[i + 1][j + 1][1], dp[i][j][1] + 1);
                        }
                    }
                }
            }
        }

        int ans = Integer.MAX_VALUE;
        for (int j = 0; j <= m; j++) {
            ans = Math.min(ans, dp[n][j][0]);
            ans = Math.min(ans, dp[n][j][1]);
        }

        return ans == Integer.MAX_VALUE / 2 ? -1 : ans;
    }
}