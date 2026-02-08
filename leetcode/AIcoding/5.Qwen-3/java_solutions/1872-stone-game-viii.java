public class Solution {

import java.util.*;

public class Solution {
    public int stoneGameVIII(List<Integer> piles) {
        int n = piles.size();
        int[] prefix = new int[n];
        prefix[0] = piles.get(0);
        for (int i = 1; i < n; i++) {
            prefix[i] = prefix[i - 1] + piles.get(i);
        }

        int[] dp = new int[n];
        dp[n - 1] = prefix[n - 1];

        for (int i = n - 2; i >= 0; i--) {
            dp[i] = Math.max(dp[i + 1], prefix[i] - dp[i + 1]);
        }

        return dp[0];
    }
}
}