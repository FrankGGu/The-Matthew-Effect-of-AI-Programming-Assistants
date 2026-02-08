public class Solution {

import java.util.*;

public class Solution {
    public int maxJump(int[] stones) {
        int n = stones.length;
        int[] dp = new int[n];
        dp[0] = 0;
        for (int i = 1; i < n; i++) {
            dp[i] = Integer.MIN_VALUE;
            for (int j = 0; j < i; j++) {
                if (j + 1 == i || stones[i] - stones[j] <= 2) {
                    dp[i] = Math.max(dp[i], dp[j] + Math.abs(stones[i] - stones[j]));
                }
            }
        }
        return dp[n - 1];
    }
}
}