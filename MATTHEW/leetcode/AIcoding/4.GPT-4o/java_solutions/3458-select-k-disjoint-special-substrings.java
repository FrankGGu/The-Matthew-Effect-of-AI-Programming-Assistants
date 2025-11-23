import java.util.*;

public class Solution {
    public int maxSpecialSubstring(String s, int k) {
        int n = s.length();
        int[] dp = new int[n + 1];
        Map<String, Integer> countMap = new HashMap<>();

        for (int i = 1; i <= n; i++) {
            String sub = String.valueOf(s.charAt(i - 1));
            countMap.put(sub, countMap.getOrDefault(sub, 0) + 1);
            dp[i] = dp[i - 1];
            if (countMap.get(sub) == 1) {
                dp[i] = Math.max(dp[i], dp[i - 1] + 1);
            }
        }

        return dp[n] < k ? 0 : dp[n];
    }
}