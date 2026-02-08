import java.util.Arrays;

public class Solution {
    public int maxTwoEvents(int[][] events) {
        Arrays.sort(events, (a, b) -> a[0] - b[0]);
        int n = events.length;
        int[] dp = new int[n];
        int max = 0;

        for (int i = 0; i < n; i++) {
            dp[i] = events[i][2];
            for (int j = 0; j < i; j++) {
                if (events[j][1] < events[i][0]) {
                    dp[i] = Math.max(dp[i], dp[j] + events[i][2]);
                }
            }
            max = Math.max(max, dp[i]);
        }

        return max;
    }
}