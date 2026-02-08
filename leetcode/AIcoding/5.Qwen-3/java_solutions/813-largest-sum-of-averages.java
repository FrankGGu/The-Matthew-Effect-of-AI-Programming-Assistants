public class Solution {

import java.util.*;

public class Solution {
    public double largestSumOfAverages(int[] nums, int k) {
        int n = nums.length;
        double[] dp = new double[n + 1];
        double[] prefix = new double[n + 1];

        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        for (int i = 1; i <= n; ++i) {
            dp[i] = prefix[i];
        }

        for (int j = 2; j <= k; ++j) {
            double[] newDp = new double[n + 1];
            for (int i = 1; i <= n; ++i) {
                newDp[i] = 0;
                for (int m = j - 1; m < i; ++m) {
                    newDp[i] = Math.max(newDp[i], dp[m] + (prefix[i] - prefix[m]));
                }
            }
            dp = newDp;
        }

        return dp[n];
    }
}
}