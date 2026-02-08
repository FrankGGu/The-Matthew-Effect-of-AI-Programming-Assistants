public class Solution {

import java.util.*;

public class Solution {
    public boolean splitArray(int[] nums) {
        int n = nums.length;
        if (n < 2) return false;
        Arrays.sort(nums);
        int sum = 0;
        for (int num : nums) sum += num;
        int[][] dp = new int[n + 1][n + 1];
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], -1);
        }
        dp[0][0] = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i; j >= 0; j--) {
                for (int k = 0; k <= j; k++) {
                    if (dp[j][k] != -1) {
                        int val = dp[j][k] + nums[i];
                        if (val * (j + 1 - k) == (sum - val) * k) {
                            return true;
                        }
                        if (dp[j + 1][k + 1] < val) {
                            dp[j + 1][k + 1] = val;
                        }
                    }
                }
            }
        }
        return false;
    }
}
}