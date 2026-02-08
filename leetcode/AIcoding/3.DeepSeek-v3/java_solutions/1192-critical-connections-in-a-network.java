class Solution {
    private int time = 0;

    public List<List<Integer>> criticalConnections(int n, List<List<Integer>> connections) {
        List<List<Integer>> result = new ArrayList<>();
        List<Integer>[] graph = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            graph[i] = new ArrayList<>();
        }
        for (List<Integer> connection : connections) {
            int u = connection.get(0);
            int v = connection.get(1);
            graph[u].add(v);
            graph[v].add(u);
        }

        int[] disc = new int[n];
        int[] low = new int[n];
        int[] parent = new int[n];
        Arrays.fill(disc, -1);
        Arrays.fill(parent, -1);

        for (int i = 0; i < n; i++) {
            if (disc[i] == -1) {
                dfs(i, disc, low, parent, graph, result);
            }
        }
        return result;
    }

    private void dfs(int u, int[] disc, int[] low, int[] parent, List<Integer>[] graph, List<List<Integer>> result) {
        disc[u] = low[u] = ++time;

        for (int v : graph[u]) {
            if (disc[v] == -1) {
                parent[v] = u;
                dfs(v, disc, low, parent, graph, result);
                low[u] = Math.min(low[u], low[v]);

                if (low[v] > disc[u]) {
                    result.add(Arrays.asList(u, v));
                }
            } else if (v != parent[u]) {
                low[u] = Math.min(low[u], disc[v]);
            }
        }
    }
}