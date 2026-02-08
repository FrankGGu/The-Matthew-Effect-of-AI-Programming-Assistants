public class Solution {

import java.util.*;

public class Solution {
    public int minJump(int[] stones) {
        if (stones == null || stones.length < 2) return 0;
        int n = stones.length;
        int[] dp = new int[n];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < i; j++) {
                int diff = stones[i] - stones[j];
                if (diff <= 2) {
                    dp[i] = Math.min(dp[i], dp[j] + 1);
                } else {
                    dp[i] = Math.min(dp[i], dp[j] + 2);
                }
            }
        }
        return dp[n - 1];
    }
}
}