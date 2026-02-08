import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minCostGoodCaption(String target, String[] words, int[] costs) {
        int n = target.length();
        int[] dp = new int[n + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        Map<String, Integer> wordCosts = new HashMap<>();
        for (int i = 0; i < words.length; i++) {
            wordCosts.put(words[i], Math.min(wordCosts.getOrDefault(words[i], Integer.MAX_VALUE), costs[i]));
        }

        for (int i = 1; i <= n; i++) {
            for (Map.Entry<String, Integer> entry : wordCosts.entrySet()) {
                String word = entry.getKey();
                int cost = entry.getValue();

                if (i >= word.length()) {
                    String sub = target.substring(i - word.length(), i);
                    if (sub.equals(word)) {
                        if (dp[i - word.length()] != Integer.MAX_VALUE) {
                            dp[i] = Math.min(dp[i], dp[i - word.length()] + cost);
                        }
                    }
                }
            }
        }

        return dp[n] == Integer.MAX_VALUE ? -1 : dp[n];
    }
}