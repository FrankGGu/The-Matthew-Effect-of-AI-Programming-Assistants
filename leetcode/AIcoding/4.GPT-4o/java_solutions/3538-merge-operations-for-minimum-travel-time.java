import java.util.*;

public class Solution {
    public long minimumTravelTime(int[][] time, int maxTime) {
        int n = time.length;
        long left = 0, right = (long) 1e18;
        while (left < right) {
            long mid = left + (right - left) / 2;
            if (canComplete(mid, time, maxTime)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left == (long) 1e18 ? -1 : left;
    }

    private boolean canComplete(long mid, int[][] time, int maxTime) {
        int n = time.length;
        long[] dp = new long[n];
        Arrays.fill(dp, Long.MAX_VALUE);
        dp[0] = 0;
        for (int i = 0; i < n; i++) {
            if (dp[i] > mid) return false;
            for (int j = i + 1; j < n; j++) {
                dp[j] = Math.min(dp[j], dp[i] + time[i][j]);
            }
        }
        return dp[n - 1] <= maxTime;
    }
}