class Solution {
    private static final int MOD = 1_000_000_007;

    public int[] countPairs(int n, int[][] edges) {
        List<Integer>[] graph = new List[n];
        for (int i = 0; i < n; i++) {
            graph[i] = new ArrayList<>();
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            graph[u].add(v);
            graph[v].add(u);
        }

        boolean[] visited = new boolean[n];
        List<Integer> components = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                int size = dfs(i, graph, visited);
                components.add(size);
            }
        }

        int total = 0;
        int[] res = new int[components.size() - 1];
        int sum = 0;
        for (int i = 0; i < components.size() - 1; i++) {
            sum += components.get(i);
            res[i] = (int) ((long) sum * components.get(i + 1) % MOD);
            total = (total + res[i]) % MOD;
        }

        return res;
    }

    private int dfs(int node, List<Integer>[] graph, boolean[] visited) {
        visited[node] = true;
        int size = 1;
        for (int neighbor : graph[node]) {
            if (!visited[neighbor]) {
                size += dfs(neighbor, graph, visited);
            }
        }
        return size;
    }
}