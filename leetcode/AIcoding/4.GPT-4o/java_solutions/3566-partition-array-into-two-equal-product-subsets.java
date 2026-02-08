import java.util.Arrays;

public class Solution {
    public boolean canPartition(int[] nums) {
        int product = 1;
        for (int num : nums) {
            product *= num;
        }
        if (product % 2 != 0) return false;

        int target = product / 2;
        int n = nums.length;
        boolean[] dp = new boolean[target + 1];
        dp[0] = true;

        for (int num : nums) {
            for (int j = target; j >= num; j--) {
                dp[j] = dp[j] || dp[j - num];
            }
        }
        return dp[target];
    }
}