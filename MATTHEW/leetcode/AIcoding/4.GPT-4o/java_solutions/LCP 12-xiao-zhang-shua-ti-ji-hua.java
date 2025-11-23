class Solution {
    public int maxQuestions(int[] questions, int time) {
        int n = questions.length;
        int[] dp = new int[time + 1];

        for (int i = 0; i < n; i++) {
            int qTime = questions[i][0];
            int qScore = questions[i][1];
            for (int t = time; t >= qTime; t--) {
                dp[t] = Math.max(dp[t], dp[t - qTime] + qScore);
            }
        }

        int maxScore = 0;
        for (int t = 0; t <= time; t++) {
            maxScore = Math.max(maxScore, dp[t]);
        }

        return maxScore;
    }
}