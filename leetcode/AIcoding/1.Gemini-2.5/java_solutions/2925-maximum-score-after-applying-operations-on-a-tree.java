import java.util.ArrayList;
import java.util.List;

class Solution {
    private long[][] dp; // dp[node][0] = max score if node is NOT chosen, dp[node][1] = max score if node IS chosen
    private List<List<Integer>> adj;
    private int[] values;

    public long maximumScoreAfterOperations(int[][] edges, int[] values) {
        int n = values.length;
        this.values = values;
        this.adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        dp = new long[n][2];

        dfs(0, -1); // Start DFS from node 0, with -1 as its parent

        // The overall maximum score is the maximum of choosing the root or not choosing the root.
        // If all values are negative, the best score might be 0 (by choosing nothing).
        // Our DP naturally handles this, as dp[u][0] is initialized to 0 and can remain 0 if no positive scores are found in children.
        // For a single node tree (n=1), dp[0][0]=0, dp[0][1]=values[0]. max(0, values[0]) is correct.
        return Math.max(dp[0][0], dp[0][1]);
    }

    private void dfs(int u, int parent) {
        // Initialize dp values for node u
        // If u is not chosen, its value is not added.
        dp[u][0] = 0; 
        // If u is chosen, its value is added.
        dp[u][1] = values[u]; 

        for (int v : adj.get(u)) {
            if (v == parent) {
                continue;
            }
            dfs(v, u); // Recursively call DFS for children

            // Update dp values for u based on children's dp values

            // If u is chosen (dp[u][1]), its children cannot be chosen.
            // So, for each child v, we must take the score where v is NOT chosen (dp[v][0]).
            dp[u][1] += dp[v][0];

            // If u is not chosen (dp[u][0]), its children can either be chosen or not chosen.
            // For each child v, take the maximum of these two options (dp[v][0] or dp[v][1]).
            dp[u][0] += Math.max(dp[v][0], dp[v][1]);
        }
    }
}