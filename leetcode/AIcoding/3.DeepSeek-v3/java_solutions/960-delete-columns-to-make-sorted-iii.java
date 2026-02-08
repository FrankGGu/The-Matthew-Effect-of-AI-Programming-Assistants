class Solution {
    public int minDeletionSize(String[] strs) {
        int m = strs.length;
        int n = strs[0].length();
        int[] dp = new int[n];
        Arrays.fill(dp, 1);
        int max = 1;

        for (int i = 1; i < n; i++) {
            for (int j = 0; j < i; j++) {
                boolean valid = true;
                for (int k = 0; k < m; k++) {
                    if (strs[k].charAt(j) > strs[k].charAt(i)) {
                        valid = false;
                        break;
                    }
                }
                if (valid) {
                    dp[i] = Math.max(dp[i], dp[j] + 1);
                }
            }
            max = Math.max(max, dp[i]);
        }

        return n - max;
    }
}