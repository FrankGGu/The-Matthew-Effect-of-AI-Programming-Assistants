import java.util.ArrayList;
import java.util.List;

class Solution {
    private static final int MAXN = 10001; // Max number of nodes + 1
    private static final int LOGN = 14;    // log2(MAXN) approx 13.2, so 14 is safe
    private static final int MAX_WEIGHT = 26; // Max edge weight

    private List<int[]>[] adj;
    private int[] depth;
    private int[][] parent; // parent[k][i] is the 2^k-th ancestor of i
    private int[][] pathCounts; // pathCounts[i][w] is count of weight 'w' edges from root to i

    public int[] minOperationsQueries(int n, int[][] edges, int[][] queries) {
        adj = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            adj[i] = new ArrayList<>();
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            adj[u].add(new int[]{v, w});
            adj[v].add(new int[]{u, w});
        }

        depth = new int[n];
        parent = new int[LOGN][n];
        pathCounts = new int[n][MAX_WEIGHT + 1];

        for (int i = 0; i < n; i++) {
            for (int k = 0; k < LOGN; k++) {
                parent[k][i] = -1; // Initialize parent entries to -1
            }
        }

        // DFS from root (node 0)
        dfs(0, -1, 0, new int[MAX_WEIGHT + 1]);

        // Build parent table for binary lifting
        for (int k = 1; k < LOGN; k++) {
            for (int i = 0; i < n; i++) {
                if (parent[k - 1][i] != -1) {
                    parent[k][i] = parent[k - 1][parent[k - 1][i]];
                }
            }
        }

        int[] results = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int u = queries[i][0];
            int v = queries[i][1];
            results[i] = solveQuery(u, v);
        }

        return results;
    }

    private void dfs(int u, int p, int d, int[] currentPathCounts) {
        depth[u] = d;
        parent[0][u] = p; // p is the direct parent (2^0-th ancestor)

        System.arraycopy(currentPathCounts, 0, pathCounts[u], 0, MAX_WEIGHT + 1);

        for (int[] edge : adj[u]) {
            int v = edge[0];
            int w = edge[1];
            if (v == p) {
                continue;
            }
            currentPathCounts[w]++; // Increment count for this weight
            dfs(v, u, d + 1, currentPathCounts);
            currentPathCounts[w]--; // Decrement count for backtracking
        }
    }

    private int getLCA(int u, int v) {
        // Ensure u is deeper or at same depth as v
        if (depth[u] < depth[v]) {
            int temp = u;
            u = v;
            v = temp;
        }

        // Lift u to the same depth as v
        for (int k = LOGN - 1; k >= 0; k--) {
            if (parent[k][u] != -1 && depth[parent[k][u]] >= depth[v]) {
                u = parent[k][u];
            }
        }

        if (u == v) {
            return u;
        }

        // Lift u and v simultaneously
        for (int k = LOGN - 1; k >= 0; k--) {
            if (parent[k][u] != -1 && parent[k][v] != -1 && parent[k][u] != parent[k][v]) {
                u = parent[k][u];
                v = parent[k][v];
            }
        }

        return parent[0][u]; // Return the parent of the current u (which is also parent of v)
    }

    private int solveQuery(int u, int v) {
        int lca = getLCA(u, v);

        int totalEdges = depth[u] + depth[v] - 2 * depth[lca];
        int maxFreq = 0;

        for (int w = 1; w <= MAX_WEIGHT; w++) {
            int freq_w = pathCounts[u][w] + pathCounts[v][w] - 2 * pathCounts[lca][w];
            maxFreq = Math.max(maxFreq, freq_w);
        }

        return totalEdges - maxFreq;
    }
}