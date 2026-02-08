public class Solution {

import java.util.*;

public class Solution {
    public int longestBinarySubsequenceLessThanOrEqualToK(String binary, int k) {
        int n = binary.length();
        int[] dp = new int[n + 1];
        Arrays.fill(dp, -1);
        dp[0] = 0;

        for (int i = 0; i < n; i++) {
            if (binary.charAt(i) == '0') {
                dp[i + 1] = dp[i];
            } else {
                dp[i + 1] = dp[i] + 1;
            }
        }

        for (int i = 1; i <= n; i++) {
            if (dp[i] == -1) continue;
            long val = 0;
            for (int j = i - 1; j >= 0; j--) {
                if (binary.charAt(j) == '1') {
                    val = val * 2 + 1;
                } else {
                    val = val * 2;
                }
                if (val > k) break;
                if (dp[j] != -1) {
                    dp[i] = Math.max(dp[i], dp[j] + (i - j));
                }
            }
        }

        return dp[n];
    }
}
}