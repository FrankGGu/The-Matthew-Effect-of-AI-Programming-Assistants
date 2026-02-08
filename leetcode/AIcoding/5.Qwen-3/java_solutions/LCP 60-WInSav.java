public class Solution {

import java.util.*;

public class Solution {
    public int findMinMoves(int n, int k) {
        int[] dp = new int[n + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= k && j <= i; j++) {
                if (dp[i - j] != Integer.MAX_VALUE) {
                    dp[i] = Math.min(dp[i], dp[i - j] + 1);
                }
            }
        }

        return dp[n];
    }
}
}