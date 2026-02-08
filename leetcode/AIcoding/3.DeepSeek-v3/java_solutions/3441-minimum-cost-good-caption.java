class Solution {
    public int minimumCost(String sentence, int k) {
        String[] words = sentence.split(" ");
        int n = words.length;
        int[] dp = new int[n + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[n] = 0;

        for (int i = n - 1; i >= 0; i--) {
            int len = 0;
            for (int j = i; j < n; j++) {
                len += words[j].length();
                if (len + (j - i) > k) break;
                if (j == n - 1) {
                    dp[i] = 0;
                } else if (dp[j + 1] != Integer.MAX_VALUE) {
                    int cost = (k - len - (j - i)) * (k - len - (j - i));
                    dp[i] = Math.min(dp[i], cost + dp[j + 1]);
                }
            }
        }
        return dp[0];
    }
}