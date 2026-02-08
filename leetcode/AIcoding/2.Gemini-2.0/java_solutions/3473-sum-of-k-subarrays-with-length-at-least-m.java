import java.util.Arrays;

public class Solution {
    public int maxSum(int[] nums, int m, int k) {
        int n = nums.length;
        long[] prefixSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        long[] dp = new long[n + 1];
        Arrays.fill(dp, Integer.MIN_VALUE);
        dp[0] = 0;

        for (int i = 1; i <= k; i++) {
            long[] newDp = new long[n + 1];
            Arrays.fill(newDp, Integer.MIN_VALUE);

            for (int j = 1; j <= n; j++) {
                newDp[j] = newDp[j - 1];
                if (j >= m && dp[j - m] != Integer.MIN_VALUE) {
                    newDp[j] = Math.max(newDp[j], dp[j - m] + prefixSum[j] - prefixSum[j - m]);
                }
            }
            dp = newDp;
        }

        long result = Integer.MIN_VALUE;
        for (int i = 1; i <= n; i++) {
            result = Math.max(result, dp[i]);
        }

        return (int) result;
    }
}