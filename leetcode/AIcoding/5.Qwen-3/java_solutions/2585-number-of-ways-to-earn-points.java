public class Solution {

import java.util.*;

public class Solution {
    public int numberOfWays(int n, int[][] ways) {
        Map<Integer, List<int[]>> graph = new HashMap<>();
        for (int[] way : ways) {
            graph.putIfAbsent(way[0], new ArrayList<>());
            graph.get(way[0]).add(new int[]{way[1], way[2]});
        }

        int[] dp = new int[n + 1];
        dp[0] = 1;

        for (int i = 1; i <= n; i++) {
            if (graph.containsKey(i)) {
                for (int[] next : graph.get(i)) {
                    int j = next[0];
                    int k = next[1];
                    if (i - k >= 0) {
                        dp[j] += dp[i - k];
                    }
                }
            }
        }

        return dp[n];
    }
}
}