class Solution {
    public int minimumBeautifulSubstrings(String s) {
        int n = s.length();
        int[] dp = new int[n + 1];
        dp[0] = 0;

        for (int i = 1; i <= n; i++) {
            dp[i] = Integer.MAX_VALUE;
            int num = 0;
            for (int j = i - 1; j >= 0 && i - j <= 20; j--) {
                num = (num << 1) + (s.charAt(j) - '0');
                if (isBeautiful(num)) {
                    dp[i] = Math.min(dp[i], dp[j] + 1);
                }
            }
        }

        return dp[n] == Integer.MAX_VALUE ? -1 : dp[n];
    }

    private boolean isBeautiful(int num) {
        return num > 0 && (num & (num - 1)) == 0;
    }
}