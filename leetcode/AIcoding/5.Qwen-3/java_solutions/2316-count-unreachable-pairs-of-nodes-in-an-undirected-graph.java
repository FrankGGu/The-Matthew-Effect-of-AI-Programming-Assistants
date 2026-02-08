public class Solution {

import java.util.*;

class Solution {
    public int countUnreachablePairs(int[][] edges, int n) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        boolean[] visited = new boolean[n];
        List<Integer> componentSizes = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                int size = dfs(i, graph, visited);
                componentSizes.add(size);
            }
        }

        long total = 0;
        long sum = 0;
        for (int size : componentSizes) {
            total += (long) size * (n - size);
            sum += size;
        }

        return (int) (total / 2);
    }

    private int dfs(int node, List<List<Integer>> graph, boolean[] visited) {
        visited[node] = true;
        int size = 1;
        for (int neighbor : graph.get(node)) {
            if (!visited[neighbor]) {
                size += dfs(neighbor, graph, visited);
            }
        }
        return size;
    }
}
}