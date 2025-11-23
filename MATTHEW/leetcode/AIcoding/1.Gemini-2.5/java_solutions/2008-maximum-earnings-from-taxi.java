import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public long maxTaxiEarnings(int n, int[][] rides) {
        Map<Integer, List<int[]>> ridesByEnd = new HashMap<>();
        for (int[] ride : rides) {
            int start = ride[0];
            int end = ride[1];
            int tip = ride[2];
            int earnings = end - start + tip;
            ridesByEnd.computeIfAbsent(end, k -> new ArrayList<>()).add(new int[]{start, earnings});
        }

        long[] dp = new long[n + 1];

        for (int i = 1; i <= n; i++) {
            dp[i] = dp[i - 1];

            if (ridesByEnd.containsKey(i)) {
                for (int[] rideInfo : ridesByEnd.get(i)) {
                    int start = rideInfo[0];
                    int earnings = rideInfo[1];
                    dp[i] = Math.max(dp[i], earnings + dp[start]);
                }
            }
        }

        return dp[n];
    }
}