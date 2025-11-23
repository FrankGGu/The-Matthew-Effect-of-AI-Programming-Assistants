public class Solution {
    public int countGoodStrings(int maxLength, int minCost, int[] operations) {
        int[] dp = new int[maxLength + 1];
        dp[0] = 1;
        for (int i = 1; i <= maxLength; i++) {
            for (int[] op : operations) {
                int cost = op[0];
                int charCount = op[1];
                if (i >= cost && i - cost >= 0) {
                    dp[i] += dp[i - cost];
                }
            }
        }
        int result = 0;
        for (int i = minCost; i <= maxLength; i++) {
            result += dp[i];
        }
        return result;
    }
}