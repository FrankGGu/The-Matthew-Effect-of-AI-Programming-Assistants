class Solution {
    public int mincostTickets(int[] days, int[] costs) {
        int n = days.length;
        int[] dp = new int[days[n - 1] + 1];

        for (int i = 1; i < dp.length; i++) {
            dp[i] = dp[i - 1];
            boolean travelDay = false;
            for (int day : days) {
                if (day == i) {
                    travelDay = true;
                    break;
                }
            }

            if (travelDay) {
                dp[i] = costs[0] + (i > 0 ? dp[i - 1] : 0);
                dp[i] = Math.min(dp[i], costs[1] + (i > 7 ? dp[i - 7] : 0));
                dp[i] = Math.min(dp[i], costs[2] + (i > 30 ? dp[i - 30] : 0));
            } else {
                dp[i] = dp[i - 1];
            }
        }

        return dp[days[n - 1]];
    }
}