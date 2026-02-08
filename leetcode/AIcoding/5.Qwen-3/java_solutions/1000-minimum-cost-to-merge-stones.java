public class Solution {

import java.util.*;

public class Solution {
    public int mergeStones(String s) {
        int n = s.length();
        int[] prefix = new int[n + 1];
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + s.charAt(i) - '0';
        }
        int[][] dp = new int[n][n];
        for (int i = 0; i < n; ++i) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
        }
        for (int i = 0; i < n; ++i) {
            dp[i][i] = 0;
        }
        for (int len = 2; len <= n; ++len) {
            for (int i = 0; i <= n - len; ++i) {
                int j = i + len - 1;
                int sum = prefix[j + 1] - prefix[i];
                if (len % 2 == 1) {
                    dp[i][j] = dp[i][j - 1] + sum;
                } else {
                    for (int k = i; k < j; k += 2) {
                        if (dp[i][k] != Integer.MAX_VALUE && dp[k + 1][j] != Integer.MAX_VALUE) {
                            dp[i][j] = Math.min(dp[i][j], dp[i][k] + dp[k + 1][j]);
                        }
                    }
                }
            }
        }
        return dp[0][n - 1];
    }
}
}