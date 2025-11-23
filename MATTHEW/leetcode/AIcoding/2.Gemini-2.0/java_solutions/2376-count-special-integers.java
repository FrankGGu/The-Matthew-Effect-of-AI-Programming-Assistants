class Solution {
    public int countSpecialIntegers(int n) {
        String s = String.valueOf(n);
        int len = s.length();
        int[][] dp = new int[len][1 << 10];
        for (int i = 0; i < len; i++) {
            for (int j = 0; j < (1 << 10); j++) {
                dp[i][j] = -1;
            }
        }
        return dfs(0, 0, true, s, dp);
    }

    private int dfs(int i, int mask, boolean isLimit, String s, int[][] dp) {
        if (i == s.length()) {
            return 1;
        }
        if (!isLimit && dp[i][mask] != -1) {
            return dp[i][mask];
        }
        int up = isLimit ? s.charAt(i) - '0' : 9;
        int ans = 0;
        for (int j = 0; j <= up; j++) {
            if ((mask & (1 << j)) == 0) {
                ans += dfs(i + 1, (mask == 0 && j == 0) ? mask : (mask | (1 << j)), isLimit && j == up, s, dp);
            }
        }
        if (!isLimit) {
            dp[i][mask] = ans;
        }
        return ans;
    }
}