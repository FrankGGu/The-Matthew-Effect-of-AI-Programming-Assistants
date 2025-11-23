public class Solution {

import java.util.*;

public class Solution {
    public int minArraySum(int[] nums, int k, int x) {
        int n = nums.length;
        long mod = 1000000007;
        long[] dp = new long[n + 1];
        Arrays.fill(dp, 0);
        for (int i = 1; i <= n; i++) {
            dp[i] = dp[i - 1] + nums[i - 1];
        }
        for (int i = 1; i <= k; i++) {
            long[] newDp = new long[n + 1];
            Arrays.fill(newDp, 0);
            for (int j = 1; j <= n; j++) {
                newDp[j] = newDp[j - 1] + dp[j];
                if (j >= x) {
                    newDp[j] -= dp[j - x];
                }
                newDp[j] %= mod;
                if (newDp[j] < 0) {
                    newDp[j] += mod;
                }
            }
            dp = newDp;
        }
        return (int) (dp[n] % mod);
    }
}
}