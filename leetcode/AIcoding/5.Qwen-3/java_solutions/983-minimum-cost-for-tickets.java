public class Solution {

import java.util.*;

public class Solution {
    public int mincostTickets(int[] days, int[] costs) {
        Set<Integer> daySet = new HashSet<>();
        for (int day : days) {
            daySet.add(day);
        }

        int lastDay = days[days.length - 1];
        int[] dp = new int[lastDay + 1];

        for (int day = 1; day <= lastDay; day++) {
            if (!daySet.contains(day)) {
                dp[day] = dp[day - 1];
            } else {
                dp[day] = dp[day - 1] + costs[0];
                if (day >= 7) {
                    dp[day] = Math.min(dp[day], dp[day - 7] + costs[1]);
                } else {
                    dp[day] = Math.min(dp[day], costs[1]);
                }
                if (day >= 30) {
                    dp[day] = Math.min(dp[day], dp[day - 30] + costs[2]);
                } else {
                    dp[day] = Math.min(dp[day], costs[2]);
                }
            }
        }

        return dp[lastDay];
    }
}
}