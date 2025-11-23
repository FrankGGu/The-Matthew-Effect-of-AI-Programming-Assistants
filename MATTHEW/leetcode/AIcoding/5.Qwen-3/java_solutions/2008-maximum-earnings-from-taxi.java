public class Solution {

import java.util.*;

public class Solution {
    public long maxTaxiEarnings(int n, int[][] rides) {
        Arrays.sort(rides, (a, b) -> a[1] - b[1]);
        long[] dp = new long[n + 1];

        for (int[] ride : rides) {
            int start = ride[0];
            int end = ride[1];
            int earning = ride[2];
            dp[end] = Math.max(dp[end], dp[start] + earning);
            dp[end] = Math.max(dp[end], dp[end - 1]);
        }

        return dp[n];
    }
}
}