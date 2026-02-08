class Solution {
    public int maximizeActiveSections(int[][] sections) {
        int n = sections.length;
        int[] dp = new int[n + 1];
        Arrays.sort(sections, (a, b) -> a[0] - b[0]);

        for (int i = 1; i <= n; i++) {
            dp[i] = dp[i - 1];
            for (int j = i - 1; j >= 0; j--) {
                if (sections[j][1] <= sections[i - 1][0]) {
                    dp[i] = Math.max(dp[i], dp[j] + 1);
                    break;
                }
            }
        }

        return dp[n];
    }
}