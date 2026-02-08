public class Solution {

import java.util.*;

public class Solution {
    public int countPartitions(int[] nums) {
        int n = nums.length;
        int totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        int mod = 1000000007;
        int half = totalSum / 2;
        boolean[] dp = new boolean[half + 1];
        dp[0] = true;

        for (int num : nums) {
            for (int i = half; i >= num; i--) {
                if (dp[i - num]) {
                    dp[i] = true;
                }
            }
        }

        int result = 0;
        for (int i = 0; i <= half; i++) {
            if (dp[i]) {
                result++;
            }
        }

        return result % mod;
    }
}
}