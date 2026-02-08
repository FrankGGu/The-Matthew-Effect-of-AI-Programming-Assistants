import java.util.*;

class Solution {
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
        long count = 0;
        long totalNodes = n;

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                long componentSize = dfs(graph, visited, i);
                count += componentSize * (totalNodes - componentSize);
                totalNodes -= componentSize;
            }
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