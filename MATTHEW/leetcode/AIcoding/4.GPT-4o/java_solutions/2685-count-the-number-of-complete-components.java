import java.util.*;

class Solution {
    public int countCompleteComponents(int n, int[][] edges) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        boolean[] visited = new boolean[n];
        int completeCount = 0;

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                int size = dfs(graph, visited, i);
                if (size * (size - 1) / 2 == countEdges(graph, i)) {
                    completeCount++;
                }
            }
        }

        return completeCount;
    }

    private int dfs(List<List<Integer>> graph, boolean[] visited, int node) {
        visited[node] = true;
        int count = 1;
        for (int neighbor : graph.get(node)) {
            if (!visited[neighbor]) {
                count += dfs(graph, visited, neighbor);
            }
        }
        return count;
    }

    private int countEdges(List<List<Integer>> graph, int node) {
        int edges = 0;
        for (int neighbor : graph.get(node)) {
            edges++;
        }
        return edges / 2;
    }
}