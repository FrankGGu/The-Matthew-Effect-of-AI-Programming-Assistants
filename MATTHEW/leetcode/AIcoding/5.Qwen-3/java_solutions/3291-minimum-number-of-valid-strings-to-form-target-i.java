public class Solution {

import java.util.*;

public class Solution {
    public int minValidStrings(String[] words, String target) {
        Map<String, Integer> map = new HashMap<>();
        for (String word : words) {
            for (int i = 0; i < word.length(); i++) {
                String prefix = word.substring(0, i + 1);
                map.put(prefix, map.getOrDefault(prefix, Integer.MAX_VALUE) - 1);
            }
        }

        int[] dp = new int[target.length() + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int i = 1; i <= target.length(); i++) {
            for (int j = 0; j < i; j++) {
                String sub = target.substring(j, i);
                if (map.containsKey(sub)) {
                    dp[i] = Math.min(dp[i], dp[j] + 1);
                }
            }
        }

        return dp[target.length()] == Integer.MAX_VALUE ? -1 : dp[target.length()];
    }
}
}