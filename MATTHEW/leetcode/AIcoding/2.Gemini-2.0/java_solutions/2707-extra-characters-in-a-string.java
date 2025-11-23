import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

class Solution {
    public int minExtraChar(String s, String[] dictionary) {
        Set<String> dict = new HashSet<>(Arrays.asList(dictionary));
        int n = s.length();
        int[] dp = new int[n + 1];

        for (int i = 1; i <= n; i++) {
            dp[i] = dp[i - 1] + 1;
            for (int j = 1; j <= i; j++) {
                String sub = s.substring(i - j, i);
                if (dict.contains(sub)) {
                    dp[i] = Math.min(dp[i], dp[i - j]);
                }
            }
        }

        return dp[n];
    }
}