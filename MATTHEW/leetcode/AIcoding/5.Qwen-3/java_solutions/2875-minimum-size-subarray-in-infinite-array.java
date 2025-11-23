public class Solution {

import java.util.*;

public class Solution {
    public int minSizeSubarray(int[] nums, int target) {
        int n = nums.length;
        int[] prefix = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        int total = prefix[n];
        int k = target / total;
        int rem = target % total;

        int[] dp = new int[n + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j < i; j++) {
                if (prefix[i] - prefix[j] <= rem) {
                    if (dp[j] != Integer.MAX_VALUE) {
                        dp[i] = Math.min(dp[i], dp[j] + (i - j));
                    }
                }
            }
        }

        int res = Integer.MAX_VALUE;
        for (int i = 0; i <= n; i++) {
            if (dp[i] != Integer.MAX_VALUE) {
                res = Math.min(res, dp[i] + k * n);
            }
        }

        return res;
    }
}
}