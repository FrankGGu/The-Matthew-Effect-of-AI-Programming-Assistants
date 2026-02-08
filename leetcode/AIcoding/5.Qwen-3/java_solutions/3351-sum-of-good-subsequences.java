public class Solution {

import java.util.*;

public class Solution {
    public int sumOfGoodSubsequences(String s) {
        int MOD = 1000000007;
        int n = s.length();
        int[][] dp = new int[n][26];
        int total = 0;

        for (int i = 0; i < n; i++) {
            int c = s.charAt(i) - 'a';
            int count = 1;
            for (int j = 0; j < 26; j++) {
                count += dp[i - 1][j];
            }
            for (int j = 0; j < 26; j++) {
                dp[i][j] = dp[i - 1][j];
            }
            dp[i][c] = count % MOD;
            total = (total + count) % MOD;
        }

        return total;
    }
}
}