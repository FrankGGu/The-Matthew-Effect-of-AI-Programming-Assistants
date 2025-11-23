public class Solution {

import java.util.*;

public class Solution {
    public int minSumOfValues(int[] nums, int k) {
        int n = nums.length;
        int[][] dp = new int[n][k + 1];
        int[] prefix = new int[n + 1];

        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        for (int i = 0; i < n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
        }

        for (int i = 0; i < n; i++) {
            dp[i][1] = prefix[n] - prefix[i];
        }

        for (int j = 2; j <= k; j++) {
            for (int i = 0; i < n; i++) {
                for (int m = i; m < n; m++) {
                    if (dp[m][j - 1] != Integer.MAX_VALUE) {
                        dp[i][j] = Math.min(dp[i][j], dp[m][j - 1] + (prefix[m] - prefix[i]));
                    }
                }
            }
        }

        return dp[0][k];
    }
}
}