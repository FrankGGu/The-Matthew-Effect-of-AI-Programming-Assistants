class Solution {
    public int mincostTickets(int[] days, int[] costs) {
        int lastDay = days[days.length - 1];
        int[] dp = new int[lastDay + 1];
        boolean[] travelDays = new boolean[lastDay + 1];

        for (int day : days) {
            travelDays[day] = true;
        }

        for (int i = 1; i <= lastDay; i++) {
            if (!travelDays[i]) {
                dp[i] = dp[i - 1];
                continue;
            }
            int oneDayPass = dp[i - 1] + costs[0];
            int sevenDayPass = dp[Math.max(0, i - 7)] + costs[1];
            int thirtyDayPass = dp[Math.max(0, i - 30)] + costs[2];
            dp[i] = Math.min(oneDayPass, Math.min(sevenDayPass, thirtyDayPass));
        }

        return dp[lastDay];
    }
}