class Solution {
    public int minValidStrings(String[] strings, String target) {
        int n = target.length();
        int[] dp = new int[n + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int i = 0; i <= n; i++) {
            if (dp[i] == Integer.MAX_VALUE) continue;
            for (String s : strings) {
                if (i + s.length() <= n && target.startsWith(s, i)) {
                    if (dp[i + s.length()] > dp[i] + 1) {
                        dp[i + s.length()] = dp[i] + 1;
                    }
                }
            }
        }

        return dp[n] == Integer.MAX_VALUE ? -1 : dp[n];
    }
}