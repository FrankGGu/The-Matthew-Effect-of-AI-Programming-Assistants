import java.util.*;

public class Solution {
    public int maximumWeightedPath(int[][] edges, int k) {
        Map<Integer, List<int[]>> graph = new HashMap<>();
        for (int[] edge : edges) {
            graph.putIfAbsent(edge[0], new ArrayList<>());
            graph.get(edge[0]).add(new int[]{edge[1], edge[2]});
            graph.putIfAbsent(edge[1], new ArrayList<>());
            graph.get(edge[1]).add(new int[]{edge[0], edge[2]});
        }
        int maxWeight = 0;
        for (int start : graph.keySet()) {
            maxWeight = Math.max(maxWeight, dfs(graph, start, k, new boolean[graph.size()]));
        }
        return maxWeight;
    }

    private int dfs(Map<Integer, List<int[]>> graph, int node, int k, boolean[] visited) {
        if (k < 0) return 0;
        visited[node] = true;
        int maxWeight = 0;
        for (int[] neighbor : graph.get(node)) {
            if (!visited[neighbor[0]]) {
                maxWeight = Math.max(maxWeight, neighbor[1] + dfs(graph, neighbor[0], k - 1, visited));
            }
        }
        visited[node] = false;
        return maxWeight;
    }
}