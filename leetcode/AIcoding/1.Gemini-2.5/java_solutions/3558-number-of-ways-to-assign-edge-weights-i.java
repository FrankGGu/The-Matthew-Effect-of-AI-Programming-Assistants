import java.util.*;

class Solution {
    List<List<Integer>> adj;
    long[][] dp; // dp[u][color_of_parent_edge]
    boolean[] visited; // Used to track visited components in the main loop
    int MOD = 1_000_000_007;

    // This DFS function calculates the number of ways to color the subtree rooted at 'u'
    // given that the edge connecting 'u' to its parent 'p' has 'p_edge_color'.
    // It returns an array 'waysForU' where waysForU[c] is the number of ways
    // if the edge (p,u) has color 'c'.
    private long[] dfs(int u, int p) {
        // If results for node u are already computed (memoized), return them.
        // We check dp[u][1] as a sentinel, assuming colors are 1-6.
        if (dp[u][1] != -1) {
            return dp[u];
        }

        long[] waysForU = new long[7]; // waysForU[0] is unused, indices 1-6 for colors

        // Iterate through all possible colors for the edge (p,u)
        for (int c_parent_edge = 1; c_parent_edge <= 6; c_parent_edge++) {
            long currentWays = 1;
            // For each neighbor 'v' of 'u' (which is a child in the DFS tree)
            for (int v : adj.get(u)) {
                if (v == p) {
                    continue; // Skip the parent node
                }

                long[] waysForV = dfs(v, u); // Recursively get results for child subtree 'v'
                long sumChildVWays = 0;
                // Sum up ways for child 'v', ensuring the edge (u,v) (which is parent edge for 'v')
                // has a different color than the edge (p,u) (which is parent edge for 'u').
                for (int c_v_edge = 1; c_v_edge <= 6; c_v_edge++) {
                    if (c_v_edge != c_parent_edge) {
                        sumChildVWays = (sumChildVWays + waysForV[c_v_edge]) % MOD;
                    }
                }
                currentWays = (currentWays * sumChildVWays) % MOD;
            }
            waysForU[c_parent_edge] = currentWays;
        }

        // Memoize the computed results for node u
        for (int i = 1; i <= 6; i++) {
            dp[u][i] = waysForU[i];
        }
        return waysForU;
    }

    public long numberOfWays(int n, int[][] edges) {
        adj = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            adj.add(new ArrayList<>());
        }

        int[] degree = new int[n + 1];
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
            degree[edge[0]]++;
            degree[edge[1]]++;
        }

        // If any node has a degree greater than 6, it's impossible to color its incident edges distinctly.
        for (int i = 1; i <= n; i++) {
            if (degree[i] > 6) {
                return 0;
            }
        }

        // Initialize dp table with -1 to indicate uncomputed states
        dp = new long[n + 1][7];
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], -1);
        }

        visited = new boolean[n + 1]; // To keep track of visited nodes for iterating through components
        long totalWays = 1;

        // Iterate through all nodes to find connected components
        for (int i = 1; i <= n; i++) {
            if (!visited[i]) {
                // Find all nodes in the current connected component using BFS
                List<Integer> componentNodes = new ArrayList<>();
                Queue<Integer> q = new LinkedList<>();

                q.offer(i);
                visited[i] = true;
                componentNodes.add(i);

                while (!q.isEmpty()) {
                    int u = q.poll();
                    for (int v : adj.get(u)) {
                        if (!visited[v]) {
                            visited[v] = true;
                            q.offer(v);
                            componentNodes.add(v);
                        }
                    }
                }

                // Handle isolated nodes (components with 1 node and 0 edges)
                if (componentNodes.size() == 1 && degree[i] == 0) {
                    totalWays = (totalWays * 1) % MOD; // 1 way to color no edges
                } else {
                    // For components that are trees, apply tree DP
                    // The problem implies the graph is a forest (collection of trees)
                    // or that cycles are handled in a way that doesn't break this DP structure.
                    // If the graph contains cycles, this tree DP approach might lead to incorrect results
                    // or stack overflow if not explicitly handled (e.g., by cycle detection and specific logic).
                    // Given the problem title "I" and constraints, a forest assumption is common.

                    long componentWays = 0;
                    // For the root 'i' of a component, there's no actual parent edge.
                    // We sum up the ways for all possible colors for its "first" edge (conceptually).
                    long[] rootWays = dfs(i, 0); // 0 acts as a dummy parent to start the DFS
                    for (int c = 1; c <= 6; c++) {
                        componentWays = (componentWays + rootWays[c]) % MOD;
                    }
                    totalWays = (totalWays * componentWays) % MOD;
                }
            }
        }

        return totalWays;
    }
}