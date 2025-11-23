import java.util.*;

class Solution {
    List<List<Integer>> adj;
    int[] coins;
    int p;
    int k;
    int[] subtreeSize;

    public long maximumPoints(int[][] edges, int[] coins, int p, int k) {
        int n = coins.length;
        this.coins = coins;
        this.p = p;
        this.k = k;
        this.adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        this.subtreeSize = new int[n];

        long[] finalResult = dfs(0, -1);

        long maxPoints = 0;
        // The problem asks for maximum points, so we check all possible operation counts up to k.
        for (long points : finalResult) {
            maxPoints = Math.max(maxPoints, points);
        }
        return maxPoints;
    }

    // Returns a long array where result[j] is the maximum points from the subtree rooted at u,
    // using exactly j operations (either /2 or -p).
    private long[] dfs(int u, int parent) {
        subtreeSize[u] = 1;

        // dp_no_op[j]: max points if node u uses no operation, and j operations are used in its children's subtrees
        // dp_div2[j]: max points if node u uses /2 operation, and j-1 operations are used in its children's subtrees
        // dp_minus_p[j]: max points if node u uses -p operation, and j-1 operations are used in its children's subtrees

        // Initial state for node u itself (before processing children)
        // The size of these arrays is min(k, current_subtree_size) + 1
        // For a single node u, current_subtree_size is 1.

        // If u uses no operation, it consumes 0 operations.
        long[] dp_no_op = new long[Math.min(k, 1) + 1];
        Arrays.fill(dp_no_op, Long.MIN_VALUE);
        dp_no_op[0] = coins[u];

        // If u uses /2 operation, it consumes 1 operation.
        long[] dp_div2 = new long[Math.min(k, 1) + 1];
        Arrays.fill(dp_div2, Long.MIN_VALUE);
        if (k >= 1) { // Only if k allows at least one operation
            dp_div2[1] = coins[u] / 2;
        }

        // If u uses -p operation, it consumes 1 operation.
        long[] dp_minus_p = new long[Math.min(k, 1) + 1];
        Arrays.fill(dp_minus_p, Long.MIN_VALUE);
        if (k >= 1) { // Only if k allows at least one operation
            dp_minus_p[1] = coins[u] - p;
        }

        for (int v : adj.get(u)) {
            if (v == parent) {
                continue;
            }

            long[] child_results_arr = dfs(v, u);
            subtreeSize[u] += subtreeSize[v];

            // Calculate new size limit for DP arrays after merging child v
            // This is min(k, current_subtree_size_of_u_plus_children) + 1
            int new_size_limit = Math.min(k, subtreeSize[u]) + 1;

            long[] next_dp_no_op = new long[new_size_limit];
            long[] next_dp_div2 = new long[new_size_limit];
            long[] next_dp_minus_p = new long[new_size_limit];
            Arrays.fill(next_dp_no_op, Long.MIN_VALUE);
            Arrays.fill(next_dp_div2, Long.MIN_VALUE);
            Arrays.fill(next_dp_minus_p, Long.MIN_VALUE);

            // Merge dp_no_op (current state of u and its already processed children) with child_results_arr
            for (int j_u = 0; j_u < dp_no_op.length; j_u++) {
                if (dp_no_op[j_u] == Long.MIN_VALUE) continue;
                for (int j_v = 0; j_v < child_results_arr.length; j_v++) {
                    if (child_results_arr[j_v] == Long.MIN_VALUE) continue;
                    int total_ops = j_u + j_v;
                    if (total_ops < new_size_limit) { // Ensure total operations do not exceed k and current subtree size
                        next_dp_no_op[total_ops] = Math.max(next_dp_no_op[total_ops], dp_no_op[j_u] + child_results_arr[j_v]);
                    }
                }
            }

            // Merge dp_div2 with child_results_arr
            for (int j_u = 0; j_u < dp_div2.length; j_u++) {
                if (dp_div2[j_u] == Long.MIN_VALUE) continue;
                for (int j_v = 0; j_v < child_results_arr.length; j_v++) {
                    if (child_results_arr[j_v] == Long.MIN_VALUE) continue;
                    int total_ops = j_u + j_v;
                    if (total_ops < new_size_limit) {
                        next_dp_div2[total_ops] = Math.max(next_dp_div2[total_ops], dp_div2[j_u] + child_results_arr[j_v]);
                    }
                }
            }

            // Merge dp_minus_p with child_results_arr
            for (int j_u = 0; j_u < dp_minus_p.length; j_u++) {
                if (dp_minus_p[j_u] == Long.MIN_VALUE) continue;
                for (int j_v = 0; j_v < child_results_arr.length; j_v++) {
                    if (child_results_arr[j_v] == Long.MIN_VALUE) continue;
                    int total_ops = j_u + j_v;
                    if (total_ops < new_size_limit) {
                        next_dp_minus_p[total_ops] = Math.max(next_dp_minus_p[total_ops], dp_minus_p[j_u] + child_results_arr[j_v]);
                    }
                }
            }

            dp_no_op = next_dp_no_op;
            dp_div2 = next_dp_div2;
            dp_minus_p = next_dp_minus_p;
        }

        // Combine the three DP arrays for node u into a single result array
        int res_u_size = Math.min(k, subtreeSize[u]) + 1;
        long[] res_u = new long[res_u_size];
        Arrays.fill(res_u, Long.MIN_VALUE);

        for (int j = 0; j < res_u_size; j++) {
            if (j < dp_no_op.length && dp_no_op[j] != Long.MIN_VALUE) {
                res_u[j] = Math.max(res_u[j], dp_no_op[j]);
            }
            if (j < dp_div2.length && dp_div2[j] != Long.MIN_VALUE) {
                res_u[j] = Math.max(res_u[j], dp_div2[j]);
            }
            if (j < dp_minus_p.length && dp_minus_p[j] != Long.MIN_VALUE) {
                res_u[j] = Math.max(res_u[j], dp_minus_p[j]);
            }
        }

        return res_u;
    }
}