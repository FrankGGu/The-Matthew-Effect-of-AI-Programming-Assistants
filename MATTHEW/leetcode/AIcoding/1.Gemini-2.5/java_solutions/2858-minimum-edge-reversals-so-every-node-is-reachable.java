import java.util.*;

class Solution {
    List<int[]>[] adj;
    int[] ans;
    int N;

    public List<Integer> minEdgeReversals(int n, int[][] edges) {
        N = n;
        adj = new ArrayList[N];
        for (int i = 0; i < N; i++) {
            adj[i] = new ArrayList<>();
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj[u].add(new int[]{v, 0}); // Original edge u -> v, cost 0
            adj[v].add(new int[]{u, 1}); // Reversed edge v -> u, cost 1
        }

        ans = new int[N];

        ans[0] = dfs1(0, -1);

        dfs2(0, -1);

        int minReversals = Integer.MAX_VALUE;
        for (int val : ans) {
            minReversals = Math.min(minReversals, val);
        }

        List<Integer> resultNodes = new ArrayList<>();
        for (int i = 0; i < N; i++) {
            if (ans[i] == minReversals) {
                resultNodes.add(i);
            }
        }
        Collections.sort(resultNodes); 
        return resultNodes;
    }

    private int dfs1(int u, int p) {
        int reversals = 0;
        for (int[] edge : adj[u]) {
            int v = edge[0];
            int cost = edge[1]; 
            if (v == p) {
                continue;
            }
            reversals += cost; 
            reversals += dfs1(v, u);
        }
        return reversals;
    }

    private void dfs2(int u, int p) {
        for (int[] edge : adj[u]) {
            int v = edge[0];
            int cost = edge[1]; 
            if (v == p) {
                continue;
            }
            ans[v] = ans[u] - cost + (1 - cost);
            dfs2(v, u);
        }
    }
}