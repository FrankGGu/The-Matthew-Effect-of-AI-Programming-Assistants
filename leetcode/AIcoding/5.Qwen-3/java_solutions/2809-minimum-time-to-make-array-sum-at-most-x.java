public class Solution {

import java.util.*;

public class Solution {
    public long minTimeToMakeSumAtMost(int[] nums, int x) {
        int n = nums.length;
        long[] prefix = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        long total = prefix[n];
        if (total <= x) return 0;

        int[] sorted = Arrays.copyOf(nums, n);
        Arrays.sort(sorted);

        long[] dp = new long[n + 1];
        for (int i = 1; i <= n; i++) {
            dp[i] = dp[i - 1] + sorted[i - 1];
        }

        long ans = Long.MAX_VALUE;
        for (int k = 1; k <= n; k++) {
            long sum = prefix[n] - dp[k];
            if (sum <= x) {
                ans = Math.min(ans, (long) k * (k - 1) / 2);
            }
        }

        return ans;
    }
}
}