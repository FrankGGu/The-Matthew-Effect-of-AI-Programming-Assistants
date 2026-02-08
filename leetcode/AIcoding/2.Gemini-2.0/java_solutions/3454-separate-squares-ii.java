import java.util.*;

class Solution {
    public int separateSquares(int[] nums) {
        int n = nums.length;
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }

        boolean[] dp = new boolean[sum / 2 + 1];
        dp[0] = true;

        for (int num : nums) {
            for (int i = sum / 2; i >= num; i--) {
                dp[i] = dp[i] || dp[i - num];
            }
        }

        int first = 0;
        for (int i = sum / 2; i >= 0; i--) {
            if (dp[i]) {
                first = i;
                break;
            }
        }

        int second = sum - first;
        return Math.abs(first - second);
    }
}