import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

class Solution {
    public int minStickers(String[] stickers, String target) {
        Set<String> dictionarySet = new HashSet<>(Arrays.asList(stickers));

        int n = target.length();
        int[] dp = new int[n + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j < i; j++) {
                if (dp[j] != Integer.MAX_VALUE) {
                    String currentWord = target.substring(j, i);
                    if (dictionarySet.contains(currentWord)) {
                        dp[i] = Math.min(dp[i], dp[j] + 1);
                    }
                }
            }
        }

        return dp[n] == Integer.MAX_VALUE ? -1 : dp[n];
    }
}