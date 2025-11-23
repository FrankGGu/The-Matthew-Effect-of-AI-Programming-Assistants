public class Solution {

import java.util.*;

public class Solution {
    public int minValidStrings(String[] words, String target) {
        Map<Character, List<String>> map = new HashMap<>();
        for (String word : words) {
            char first = word.charAt(0);
            map.putIfAbsent(first, new ArrayList<>());
            map.get(first).add(word);
        }

        int n = target.length();
        int[] dp = new int[n + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int i = 0; i < n; i++) {
            if (dp[i] == Integer.MAX_VALUE) continue;
            char c = target.charAt(i);
            if (!map.containsKey(c)) continue;
            for (String word : map.get(c)) {
                int len = word.length();
                int j = i + len;
                if (j > n) continue;
                boolean match = true;
                for (int k = 0; k < len; k++) {
                    if (i + k >= n || target.charAt(i + k) != word.charAt(k)) {
                        match = false;
                        break;
                    }
                }
                if (match) {
                    dp[j] = Math.min(dp[j], dp[i] + 1);
                }
            }
        }

        return dp[n] == Integer.MAX_VALUE ? -1 : dp[n];
    }
}
}