import java.util.*;

class Solution {
    public int solve(int n, int[] nums, int[] next, int[] k) {
        int[] dp = new int[n];
        Arrays.fill(dp, 1);
        int ans = 1;

        for (int i = n - 1; i >= 0; i--) {
            if (next[i] != -1 && (double)nums[i] > (double)nums[next[i]] / k[i]) {
                dp[i] = Math.max(dp[i], dp[next[i]] + 1);
            }
            ans = Math.max(ans, dp[i]);
        }

        return ans;
    }

    public int solveOptimized(int n, int[] nums, int[] next, int[] k) {
        int[] dp = new int[n];
        int ans = 0;
        for (int i = 0; i < n; i++) {
            dp[i] = 1;
        }

        for (int i = n - 1; i >= 0; i--) {
            if (next[i] != -1 && (double)nums[i] > (double)nums[next[i]] / k[i]) {
                dp[i] = Math.max(dp[i], dp[next[i]] + 1);
            }
            ans = Math.max(ans, dp[i]);
        }

        return ans;
    }

    public int findMaximumLength(int[] nums, int[] next, int[] k) {
        int n = nums.length;
        return solveOptimized(n, nums, next, k);
    }
}