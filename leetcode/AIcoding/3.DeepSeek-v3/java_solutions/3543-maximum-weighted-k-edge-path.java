class Solution {
    public int maxWeight(int[][] edges, int n, int k) {
        List<int[]>[] graph = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            graph[i] = new ArrayList<>();
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            graph[u].add(new int[]{v, w});
            graph[v].add(new int[]{u, w});
        }

        int max = -1;
        for (int i = 0; i < n; i++) {
            boolean[] visited = new boolean[n];
            visited[i] = true;
            max = Math.max(max, dfs(graph, i, visited, k - 1, 0));
        }
        return max;
    }

    private int dfs(List<int[]>[] graph, int u, boolean[] visited, int k, int sum) {
        if (k == 0) {
            return sum;
        }
        int max = -1;
        for (int[] edge : graph[u]) {
            int v = edge[0], w = edge[1];
            if (!visited[v]) {
                visited[v] = true;
                max = Math.max(max, dfs(graph, v, visited, k - 1, sum + w));
                visited[v] = false;
            }
        }
        return max;
    }
}