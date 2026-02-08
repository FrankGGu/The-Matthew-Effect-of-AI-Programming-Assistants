class Solution {
    public int minDeletionSize(String[] strs) {
        int n = strs.length, m = strs[0].length();
        int[] dp = new int[m];

        for (int j = 0; j < m; j++) {
            dp[j] = 1;
            for (int k = 0; k < j; k++) {
                boolean valid = true;
                for (int i = 0; i < n; i++) {
                    if (strs[i].charAt(k) > strs[i].charAt(j)) {
                        valid = false;
                        break;
                    }
                }
                if (valid) {
                    dp[j] = Math.max(dp[j], dp[k] + 1);
                }
            }
        }

        return m - Arrays.stream(dp).max().getAsInt();
    }
}