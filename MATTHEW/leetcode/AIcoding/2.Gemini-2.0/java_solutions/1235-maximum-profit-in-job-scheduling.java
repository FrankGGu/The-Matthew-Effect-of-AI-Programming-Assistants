import java.util.Arrays;

class Solution {
    public int jobScheduling(int[] startTime, int[] endTime, int[] profit) {
        int n = startTime.length;
        int[][] jobs = new int[n][3];
        for (int i = 0; i < n; i++) {
            jobs[i][0] = startTime[i];
            jobs[i][1] = endTime[i];
            jobs[i][2] = profit[i];
        }
        Arrays.sort(jobs, (a, b) -> a[1] - b[1]);
        int[] dp = new int[n + 1];
        for (int i = 1; i <= n; i++) {
            int currentProfit = jobs[i - 1][2];
            int prevEndTime = jobs[i - 1][0];
            int low = 0;
            int high = i - 1;
            int index = 0;
            while (low < high) {
                int mid = (low + high) / 2;
                if (jobs[mid][1] <= prevEndTime) {
                    index = mid + 1;
                    low = mid + 1;
                } else {
                    high = mid;
                }
            }
            if (low == high && high > 0 && jobs[high - 1][1] <= prevEndTime) {
                index = high;
            }
            if (low == high && high == 0 && jobs[0][1] <= prevEndTime) {
                index = 1;
            }

            int includeProfit = currentProfit;
            if(index > 0) {
                includeProfit += dp[index];
            }

            dp[i] = Math.max(dp[i - 1], includeProfit);
        }
        return dp[n];
    }
}