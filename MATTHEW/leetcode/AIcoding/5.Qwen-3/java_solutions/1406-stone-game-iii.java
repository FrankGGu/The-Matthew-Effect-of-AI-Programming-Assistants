public class Solution {

import java.util.Arrays;

public class Solution {
    public String stoneGameIII(int[] costs) {
        int n = costs.length;
        int[] dp = new int[n + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[n] = 0;

        for (int i = n - 1; i >= 0; i--) {
            for (int j = 1; j <= 3 && i + j < n; j++) {
                if (dp[i + j] != Integer.MAX_VALUE) {
                    dp[i] = Math.min(dp[i], dp[i + j] - costs[i + j - 1]);
                }
            }
        }

        if (dp[0] > 0) {
            return "Alice";
        } else if (dp[0] < 0) {
            return "Bob";
        } else {
            return "Tie";
        }
    }
}
}