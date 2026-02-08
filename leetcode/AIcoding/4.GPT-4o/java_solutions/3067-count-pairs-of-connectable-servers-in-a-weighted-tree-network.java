class Solution {
    private long count = 0;

    public long countPairs(int n, int[][] edges) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        boolean[] visited = new boolean[n];
        List<Long> sizes = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                long size = dfs(graph, visited, i);
                sizes.add(size);
            }
        }

        long total = 0;
        long sum = 0;

        for (long size : sizes) {
            total += size;
            count += size * sum;
            sum += size;
        }

        return count;
    }

    private long dfs(List<List<Integer>> graph, boolean[] visited, int node) {
        visited[node] = true;
        long size = 1;

        for (int neighbor : graph.get(node)) {
            if (!visited[neighbor]) {
                size += dfs(graph, visited, neighbor);
            }
        }

        return size;
    }
}