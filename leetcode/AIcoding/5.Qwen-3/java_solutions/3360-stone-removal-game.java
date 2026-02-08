public class Solution {

import java.util.*;

public class Solution {
    public int[] stoneGameIII(int[] stones) {
        int n = stones.length;
        int[] dp = new int[n + 1];
        Arrays.fill(dp, Integer.MIN_VALUE);
        dp[n] = 0;

        for (int i = n - 1; i >= 0; i--) {
            for (int j = 1; j <= 3 && i + j <= n; j++) {
                dp[i] = Math.max(dp[i], stones[i] - dp[i + j]);
            }
        }

        if (dp[0] > 0) {
            return new int[]{1, 0};
        } else if (dp[0] < 0) {
            return new int[]{0, 1};
        } else {
            return new int[]{0, 0};
        }
    }
}
}