public class Solution {

import java.util.*;

public class Solution {
    public int findMaximumNonDecreasingLength(int[] nums) {
        int n = nums.length;
        if (n == 0) return 0;
        if (n == 1) return 1;

        int[] dp = new int[n];
        Arrays.fill(dp, 1);

        for (int i = 1; i < n; i++) {
            for (int j = 0; j < i; j++) {
                if (nums[j] <= nums[i]) {
                    dp[i] = Math.max(dp[i], dp[j] + 1);
                }
            }
        }

        int max = 0;
        for (int val : dp) {
            max = Math.max(max, val);
        }

        return max;
    }
}
}