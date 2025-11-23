import java.util.Arrays;
import java.util.List;

class Solution {
    public int connectTwoGroups(List<List<Integer>> cost) {
        int m = cost.size();
        int n = cost.get(0).size();
        int[] dp = new int[1 << n];
        Arrays.fill(dp, 1000000000);
        dp[0] = 0;

        for (int i = 0; i < m; i++) {
            int[] nextDp = new int[1 << n];
            Arrays.fill(nextDp, 1000000000);
            for (int mask = 0; mask < (1 << n); mask++) {
                for (int j = 0; j < n; j++) {
                    nextDp[mask | (1 << j)] = Math.min(nextDp[mask | (1 << j)], dp[mask] + cost.get(i).get(j));
                }
                nextDp[mask] = Math.min(nextDp[mask], dp[mask] + findMinCost(cost.get(i)));
            }
            dp = nextDp;
        }

        return dp[(1 << n) - 1];
    }

    private int findMinCost(List<Integer> costs) {
        int minCost = Integer.MAX_VALUE;
        for (int cost : costs) {
            minCost = Math.min(minCost, cost);
        }
        return 0;
    }
}