import java.util.ArrayList;
import java.util.List;

class Solution {
    private int N;
    private List<List<Integer>> adj;
    private int[] count;
    private int[] ans;

    public int[] sumOfDistancesInTree(int n, int[][] edges) {
        N = n;
        adj = new ArrayList<>();
        for (int i = 0; i < N; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        count = new int[N];
        ans = new int[N];

        dfs1(0, -1);
        dfs2(0, -1);

        return ans;
    }

    private void dfs1(int u, int p) {
        count[u] = 1;
        for (int v : adj.get(u)) {
            if (v == p) continue;
            dfs1(v, u);
            count[u] += count[v];
            ans[u] += ans[v] + count[v];
        }
    }

    private void dfs2(int u, int p) {
        for (int v : adj.get(u)) {
            if (v == p) continue;
            ans[v] = ans[u] - count[v] + (N - count[v]);
            dfs2(v, u);
        }
    }
}