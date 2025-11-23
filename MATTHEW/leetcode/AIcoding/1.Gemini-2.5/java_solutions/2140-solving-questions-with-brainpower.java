class Solution {
    public long mostPoints(int[][] questions) {
        int n = questions.length;
        long[] dp = new long[n + 1];

        for (int i = n - 1; i >= 0; i--) {
            int points = questions[i][0];
            int brainpower = questions[i][1];

            // Option 1: Skip the current question
            long skipPoints = dp[i + 1];

            // Option 2: Solve the current question
            long solvePoints = points;
            int nextQuestionIndex = i + 1 + brainpower;
            if (nextQuestionIndex < n) {
                solvePoints += dp[nextQuestionIndex];
            }
            // If nextQuestionIndex >= n, it means we are past the last question,
            // so no more points can be added, which is correctly handled by dp[n] = 0.

            dp[i] = Math.max(skipPoints, solvePoints);
        }

        return dp[0];
    }
}