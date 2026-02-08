class Solution {
    public int longestIdealString(String s, int k) {
        int[] dp = new int[128];
        int maxLength = 0;

        for (char c : s.toCharArray()) {
            int currentMax = 0;
            for (int j = Math.max(0, c - k); j <= Math.min(127, c + k); j++) {
                currentMax = Math.max(currentMax, dp[j]);
            }
            dp[c] = currentMax + 1;
            maxLength = Math.max(maxLength, dp[c]);
        }

        return maxLength;
    }
}