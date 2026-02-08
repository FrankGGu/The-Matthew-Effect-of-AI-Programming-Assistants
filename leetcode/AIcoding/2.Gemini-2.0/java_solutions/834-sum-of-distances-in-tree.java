class Solution {
    int[] ans, count;
    List<List<Integer>> adj;
    int n;

    public int[] sumOfDistancesInTree(int n, int[][] edges) {
        this.n = n;
        adj = new ArrayList<>();
        ans = new int[n];
        count = new int[n];
        for (int i = 0; i < n; ++i)
            adj.add(new ArrayList<>());
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            adj.get(u).add(v);
            adj.get(v).add(u);
        }

        dfs1(0, -1);
        dfs2(0, -1);
        return ans;
    }

    public void dfs1(int node, int parent) {
        count[node] = 1;
        for (int child : adj.get(node)) {
            if (child != parent) {
                dfs1(child, node);
                count[node] += count[child];
                ans[node] += ans[child] + count[child];
            }
        }
    }

    public void dfs2(int node, int parent) {
        for (int child : adj.get(node)) {
            if (child != parent) {
                ans[child] = ans[node] - count[child] + n - count[child];
                dfs2(child, node);
            }
        }
    }
}