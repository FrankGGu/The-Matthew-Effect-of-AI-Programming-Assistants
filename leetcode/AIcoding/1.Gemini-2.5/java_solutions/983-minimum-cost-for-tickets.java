import java.util.HashSet;
import java.util.Set;

class Solution {
    public int mincostTickets(int[] days, int[] costs) {
        int lastDay = days[days.length - 1];
        boolean[] isTravelDay = new boolean[lastDay + 1];
        for (int day : days) {
            isTravelDay[day] = true;
        }

        int[] dp = new int[lastDay + 1];
        dp[0] = 0;

        for (int i = 1; i <= lastDay; i++) {
            if (!isTravelDay[i]) {
                dp[i] = dp[i - 1];
            } else {
                // Option 1: 1-day pass
                dp[i] = dp[i - 1] + costs[0];

                // Option 2: 7-day pass
                dp[i] = Math.min(dp[i], dp[Math.max(0, i - 7)] + costs[1]);

                // Option 3: 30-day pass
                dp[i] = Math.min(dp[i], dp[Math.max(0, i - 30)] + costs[2]);
            }
        }

        return dp[lastDay];
    }
}