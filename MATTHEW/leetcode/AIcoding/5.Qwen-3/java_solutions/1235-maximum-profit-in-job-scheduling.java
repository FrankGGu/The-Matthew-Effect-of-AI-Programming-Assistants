public class Solution {

import java.util.*;

public class Solution {
    public int jobScheduling(int[] startTime, int[] endTime, int[] profit) {
        int n = startTime.length;
        int[][] jobs = new int[n][3];
        for (int i = 0; i < n; i++) {
            jobs[i][0] = startTime[i];
            jobs[i][1] = endTime[i];
            jobs[i][2] = profit[i];
        }
        Arrays.sort(jobs, (a, b) -> a[1] - b[1]);
        int[] dp = new int[n];
        int[] endTimes = new int[n];
        for (int i = 0; i < n; i++) {
            endTimes[i] = jobs[i][1];
        }
        for (int i = 0; i < n; i++) {
            int start = jobs[i][0];
            int profit = jobs[i][2];
            int idx = Arrays.binarySearch(endTimes, 0, i, start);
            if (idx < 0) {
                idx = ~idx;
            }
            if (idx > 0) {
                dp[i] = dp[idx - 1] + profit;
            } else {
                dp[i] = profit;
            }
            if (i > 0) {
                dp[i] = Math.max(dp[i], dp[i - 1]);
            }
        }
        return dp[n - 1];
    }
}
}