public class Solution {

import java.util.*;

public class Solution {
    public int minEdgeReversals(int[][] edges, int n) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            graph.get(u).add(v);
            graph.get(v).add(u);
        }

        int[] result = new int[1];
        boolean[] visited = new boolean[n];

        dfs(0, -1, graph, visited, result);

        return result[0];
    }

    private int dfs(int node, int parent, List<List<Integer>> graph, boolean[] visited, int[] result) {
        visited[node] = true;
        int count = 0;

        for (int neighbor : graph.get(node)) {
            if (!visited[neighbor]) {
                count += dfs(neighbor, node, graph, visited, result);
                if (neighbor != parent) {
                    count++;
                }
            }
        }

        result[0] += count;
        return count;
    }
}
}