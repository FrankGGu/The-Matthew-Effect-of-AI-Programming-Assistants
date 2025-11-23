public class Solution {

import java.util.*;

public class Solution {
    public int minimumTime(String blocks) {
        int n = blocks.length();
        int[] dp = new int[n];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;
        for (int i = 1; i < n; i++) {
            if (blocks.charAt(i) == '0') {
                dp[i] = dp[i - 1];
            } else {
                dp[i] = dp[i - 1] + 1;
                for (int j = 0; j < i; j++) {
                    if (blocks.charAt(j) == '0') {
                        dp[i] = Math.min(dp[i], dp[j] + i - j);
                    }
                }
            }
        }
        return dp[n - 1];
    }
}
}