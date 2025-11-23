import java.util.Arrays;

class Solution {
    public int maximumPoints(int[] edges, int[] cost) {
        int n = cost.length;
        int[] dp = new int[n];
        Arrays.fill(dp, -1);

        int root = -1;
        for (int i = 0; i < n; i++) {
            if (edges[i] == -1) {
                root = i;
                break;
            }
        }

        int maxPoints = dfs(root, edges, cost, dp);
        return maxPoints;
    }

    private int dfs(int node, int[] edges, int[] cost, int[] dp) {
        if (dp[node] != -1) {
            return dp[node];
        }

        int maxChildPoints = 0;
        boolean hasChild = false;
        for (int i = 0; i < edges.length; i++) {
            if (edges[i] == node) {
                hasChild = true;
                maxChildPoints = Math.max(maxChildPoints, dfs(i, edges, cost, dp));
            }
        }

        if (!hasChild) {
            dp[node] = cost[node];
            return dp[node];
        }

        dp[node] = cost[node] + maxChildPoints;
        return dp[node];
    }
}