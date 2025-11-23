class Solution {
    public int[] loudAndRich(int[][] richer, int[] quiet) {
        int n = quiet.length;
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : richer) {
            int u = edge[0], v = edge[1];
            graph.get(v).add(u);
        }
        int[] res = new int[n];
        Arrays.fill(res, -1);
        for (int i = 0; i < n; i++) {
            dfs(i, graph, quiet, res);
        }
        return res;
    }

    private int dfs(int node, List<List<Integer>> graph, int[] quiet, int[] res) {
        if (res[node] != -1) {
            return res[node];
        }
        res[node] = node;
        for (int neighbor : graph.get(node)) {
            int candidate = dfs(neighbor, graph, quiet, res);
            if (quiet[candidate] < quiet[res[node]]) {
                res[node] = candidate;
            }
        }
        return res[node];
    }
}