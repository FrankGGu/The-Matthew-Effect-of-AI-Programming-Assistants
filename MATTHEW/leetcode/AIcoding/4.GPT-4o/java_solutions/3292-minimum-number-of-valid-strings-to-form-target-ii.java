import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int minNumberOfValidStrings(String[] words, String target) {
        Map<Character, Integer> targetCount = new HashMap<>();
        for (char c : target.toCharArray()) {
            targetCount.put(c, targetCount.getOrDefault(c, 0) + 1);
        }

        int[] dp = new int[target.length() + 1];
        dp[0] = 1;

        for (String word : words) {
            int[] currentCount = new int[target.length() + 1];
            for (char c : word.toCharArray()) {
                for (int j = target.length(); j > 0; j--) {
                    if (j >= 1 && target.charAt(j - 1) == c) {
                        currentCount[j] += dp[j - 1];
                    }
                }
            }
            for (int j = 0; j <= target.length(); j++) {
                dp[j] += currentCount[j];
            }
        }

        return dp[target.length()] > 0 ? dp[target.length()] : -1;
    }
}