public class Solution {

import java.util.*;

public class Solution {
    public int numWays(List<String> words, String target) {
        int n = words.size();
        int m = words.get(0).length();
        int k = target.length();
        int MOD = 1000000007;

        int[][] count = new int[m][26];

        for (String word : words) {
            for (int i = 0; i < m; i++) {
                count[i][word.charAt(i) - 'a']++;
            }
        }

        int[][] dp = new int[k + 1][m + 1];
        for (int i = 0; i <= m; i++) {
            dp[0][i] = 1;
        }

        for (int i = 1; i <= k; i++) {
            for (int j = 1; j <= m; j++) {
                dp[i][j] = (dp[i][j - 1] + (long) dp[i - 1][j - 1] * count[j - 1][target.charAt(i - 1) - 'a']) % MOD;
            }
        }

        return dp[k][m];
    }
}
}