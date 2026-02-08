class Solution {
    public int minDeletionSize(String[] strs) {
        int n = strs.length;
        int m = strs[0].length();
        int[] dp = new int[m];
        int ans = 0;

        for (int i = 0; i < m; i++) {
            dp[i] = 1;
            for (int j = 0; j < i; j++) {
                boolean valid = true;
                for (int k = 0; k < n; k++) {
                    if (strs[k].charAt(j) > strs[k].charAt(i)) {
                        valid = false;
                        break;
                    }
                }
                if (valid) {
                    dp[i] = Math.max(dp[i], dp[j] + 1);
                }
            }
            ans = Math.max(ans, dp[i]);
        }

        return m - ans;
    }
}