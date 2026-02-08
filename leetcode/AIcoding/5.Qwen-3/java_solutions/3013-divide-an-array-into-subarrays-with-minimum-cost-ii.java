public class Solution {

import java.util.*;

public class Solution {
    public int minCostToSplitArray(int[] nums, int k) {
        int n = nums.length;
        int[] dp = new int[n];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int i = 1; i < n; i++) {
            int unique = 0;
            int[] count = new int[1001];
            for (int j = i; j >= 0; j--) {
                if (count[nums[j]]++ == 0) {
                    unique++;
                }
                if (unique > k) break;
                if (j > 0) {
                    dp[i] = Math.min(dp[i], dp[j - 1] + unique);
                } else {
                    dp[i] = Math.min(dp[i], unique);
                }
            }
        }

        return dp[n - 1];
    }
}
}