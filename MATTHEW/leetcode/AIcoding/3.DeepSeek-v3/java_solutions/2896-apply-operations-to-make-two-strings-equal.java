class Solution {
    public int minOperations(String s1, String s2, int x) {
        int n = s1.length();
        List<Integer> diffIndices = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            if (s1.charAt(i) != s2.charAt(i)) {
                diffIndices.add(i);
            }
        }
        int m = diffIndices.size();
        if (m % 2 != 0) {
            return -1;
        }
        if (m == 0) {
            return 0;
        }

        int[] dp = new int[m + 1];
        dp[0] = 0;
        for (int i = 1; i <= m; i++) {
            if (i % 2 == 1) {
                dp[i] = dp[i - 1] + x;
            } else {
                dp[i] = Math.min(dp[i - 1] + x, dp[i - 2] + diffIndices.get(i - 1) - diffIndices.get(i - 2));
            }
        }
        return dp[m];
    }
}