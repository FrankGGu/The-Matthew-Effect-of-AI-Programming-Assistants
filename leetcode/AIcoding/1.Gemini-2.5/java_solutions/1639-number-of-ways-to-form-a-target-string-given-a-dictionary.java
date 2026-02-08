import java.util.List;

class Solution {
    public int numWays(String[] words, String target) {
        int targetLen = target.length();
        int wordLen = words[0].length(); 
        long MOD = 1_000_000_007;

        int[][] count = new int[wordLen][26];
        for (String word : words) {
            for (int j = 0; j < wordLen; j++) {
                count[j][word.charAt(j) - 'a']++;
            }
        }

        long[] dp = new long[wordLen + 1];

        for (int j = 0; j <= wordLen; j++) {
            dp[j] = 1;
        }

        for (int i = 1; i <= targetLen; i++) {
            long prevDpValAtJMinus1 = dp[0]; 
            dp[0] = 0; 

            for (int j = 1; j <= wordLen; j++) {
                long currentDpValAtJ = dp[j]; 

                dp[j] = dp[j-1]; 

                int charToMatch = target.charAt(i - 1) - 'a';
                int freq = count[j - 1][charToMatch];

                if (freq > 0) {
                    long waysToMatchCurrentChar = (prevDpValAtJMinus1 * freq) % MOD;
                    dp[j] = (dp[j] + waysToMatchCurrentChar) % MOD;
                }

                prevDpValAtJMinus1 = currentDpValAtJ; 
            }
        }

        return (int) dp[wordLen];
    }
}