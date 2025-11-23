import java.util.Arrays;

class Solution {
    public int defendSpaceCity(int[] time, int[] position) {
        int n = time.length;
        int maxTime = 0;
        for (int t : time) {
            maxTime = Math.max(maxTime, t);
        }

        int[] needed = new int[maxTime + 1];
        for (int i = 0; i < n; i++) {
            needed[time[i]] = Math.max(needed[time[i]], position[i]);
        }

        int[] dp = new int[maxTime + 2];
        Arrays.fill(dp, 0);

        for (int i = 1; i <= maxTime + 1; i++) {
            dp[i] = Math.max(dp[i - 1], dp[i - 2] + needed[Math.max(0, i - 1)]);
        }

        return dp[maxTime + 1];
    }
}