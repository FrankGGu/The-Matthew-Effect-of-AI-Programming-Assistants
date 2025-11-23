class Solution {
    public long mostPoints(int[][] questions) {
        int n = questions.length;
        long[] dp = new long[n + 1];
        for (int i = n - 1; i >= 0; i--) {
            int points = questions[i][0];
            int brainpower = questions[i][1];
            int next = i + brainpower + 1;
            if (next < n) {
                dp[i] = Math.max(points + dp[next], dp[i + 1]);
            } else {
                dp[i] = Math.max(points, dp[i + 1]);
            }
        }
        return dp[0];
    }
}