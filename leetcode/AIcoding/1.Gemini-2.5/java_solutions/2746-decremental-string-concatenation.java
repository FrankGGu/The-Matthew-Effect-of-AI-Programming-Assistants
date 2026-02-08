import java.util.Arrays;
import java.util.List;

class Solution {
    public int minimizeConcatenatedLength(List<String> words) {
        int n = words.size();

        int[] dp = new int[26];
        Arrays.fill(dp, Integer.MAX_VALUE);

        String firstWord = words.get(0);
        int firstWordLen = firstWord.length();
        char firstWordLastChar = firstWord.charAt(firstWordLen - 1);

        dp[firstWordLastChar - 'a'] = firstWordLen;

        for (int i = 1; i < n; i++) {
            int[] nextDp = new int[26];
            Arrays.fill(nextDp, Integer.MAX_VALUE);

            String currentWord = words.get(i);
            int currentWordLen = currentWord.length();
            char currentWordFirstChar = currentWord.charAt(0);
            char currentWordLastChar = currentWord.charAt(currentWordLen - 1);
            int currentWordLastCharIdx = currentWordLastChar - 'a';

            for (int prevLastCharIdx = 0; prevLastCharIdx < 26; prevLastCharIdx++) {
                if (dp[prevLastCharIdx] == Integer.MAX_VALUE) {
                    continue;
                }

                char prevLastChar = (char)('a' + prevLastCharIdx);

                int costToAdd = currentWordLen;
                if (prevLastChar == currentWordFirstChar) {
                    costToAdd--;
                }

                int newTotalCost = dp[prevLastCharIdx] + costToAdd;
                nextDp[currentWordLastCharIdx] = Math.min(nextDp[currentWordLastCharIdx], newTotalCost);
            }
            dp = nextDp;
        }

        int minCost = Integer.MAX_VALUE;
        for (int j = 0; j < 26; j++) {
            minCost = Math.min(minCost, dp[j]);
        }

        return minCost;
    }
}