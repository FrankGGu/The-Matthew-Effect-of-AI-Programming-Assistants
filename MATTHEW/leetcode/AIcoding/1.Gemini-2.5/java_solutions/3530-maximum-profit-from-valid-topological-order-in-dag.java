import java.util.*;

class Solution {
    public int maximumProfit(int n, int[][] edges, int[] profits) {
        // Build adjacency list to represent the DAG
        List<List<Integer>> adj = new ArrayList<>();
        // inDegree array to store the number of incoming edges for each node
        int[] inDegree = new int[n];

        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        // Populate adjacency list and in-degrees
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj.get(u).add(v);
            inDegree[v]++;
        }

        // dp[i] will store the maximum profit of a valid topological path ending at node i
        int[] dp = new int[n];
        // Initialize dp values with the individual profit of each node.
        // A path ending at node i can simply be node i itself.
        for (int i = 0; i < n; i++) {
            dp[i] = profits[i];
        }

        // Queue for Kahn's algorithm (topological sort)
        Queue<Integer> q = new LinkedList<>();
        // Add all nodes with an in-degree of 0 to the queue (source nodes)
        for (int i = 0; i < n; i++) {
            if (inDegree[i] == 0) {
                q.offer(i);
            }
        }

        // Process nodes in topological order
        while (!q.isEmpty()) {
            int u = q.poll();

            // For each neighbor v of u
            for (int v : adj.get(u)) {
                // Update dp[v]: A path ending at v can either be its current best path,
                // or a path coming from u (dp[u] + profits[v]).
                // We take the maximum of these possibilities.
                dp[v] = Math.max(dp[v], dp[u] + profits[v]);

                // Decrement in-degree of v as u has been processed
                inDegree[v]--;
                // If v's in-degree becomes 0, it means all its predecessors have been processed,
                // so add v to the queue.
                if (inDegree[v] == 0) {
                    q.offer(v);
                }
            }
        }

        // The maximum profit will be the maximum value found in the dp array.
        // This represents the maximum profit of any valid topological path in the DAG.
        int maxProfit = Integer.MIN_VALUE;
        if (n == 0) {
            return 0; // Handle the case of an empty graph
        }

        for (int profit : dp) {
            maxProfit = Math.max(maxProfit, profit);
        }

        return maxProfit;
    }
}