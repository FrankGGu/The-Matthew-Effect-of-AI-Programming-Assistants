import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Solution {
    List<List<Integer>> adj;
    int[] quiet;
    int[] ans;

    public int[] loudAndRich(int[][] richer, int[] quiet) {
        int n = quiet.length;
        this.quiet = quiet;
        this.ans = new int[n];
        Arrays.fill(ans, -1);

        adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        // Build the graph where adj[v] contains u if u is richer than v.
        // This means for a person v, we want to find the min quietness among v and all its ancestors in the 'richer' graph.
        // An edge u -> v in the problem statement means u is richer than v.
        // To find ancestors of v, we need edges from v to u. So, we add u to adj[v].
        for (int[] r : richer) {
            int u = r[0]; // u is richer
            int v = r[1]; // v is less rich
            adj.get(v).add(u); // Add a directed edge from v to u, meaning u is a direct 'richer' parent of v
        }

        for (int i = 0; i < n; i++) {
            dfs(i);
        }

        return ans;
    }

    private int dfs(int u) {
        // If the answer for u has already been computed, return it.
        if (ans[u] != -1) {
            return ans[u];
        }

        // Initialize the answer for u with u itself, as u is at least as rich as u.
        ans[u] = u;

        // Explore all people who are directly richer than u (i.e., u's parents in the 'richer' hierarchy).
        for (int v : adj.get(u)) { // v is a person directly richer than u
            // Recursively find the person with minimum quietness among those richer than or equal to v.
            int richerPersonWithMinQuiet = dfs(v);

            // Compare the quietness of the current best candidate for u with the best candidate found from v's lineage.
            // If the person found through v's lineage has less quietness, update ans[u].
            if (quiet[richerPersonWithMinQuiet] < quiet[ans[u]]) {
                ans[u] = richerPersonWithMinQuiet;
            }
        }

        return ans[u];
    }
}