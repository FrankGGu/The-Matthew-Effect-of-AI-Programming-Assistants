public class Solution {

import java.util.*;

public class Solution {
    public int maxSumDivThree(int[] nums) {
        int[] dp = new int[3];
        Arrays.fill(dp, Integer.MIN_VALUE);
        dp[0] = 0;

        for (int num : nums) {
            int[] temp = Arrays.copyOf(dp, 3);
            for (int i = 0; i < 3; i++) {
                if (dp[i] != Integer.MIN_VALUE) {
                    int remainder = (dp[i] + num) % 3;
                    temp[remainder] = Math.max(temp[remainder], dp[i] + num);
                }
            }
            dp = temp;
        }

        return dp[0];
    }
}
}