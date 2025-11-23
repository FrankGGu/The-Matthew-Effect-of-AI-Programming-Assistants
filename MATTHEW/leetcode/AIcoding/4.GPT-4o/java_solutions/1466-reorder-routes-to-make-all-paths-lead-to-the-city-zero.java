import java.util.*;

public class Solution {
    public int minReorder(int n, int[][] connections) {
        Map<Integer, List<int[]>> graph = new HashMap<>();
        for (int[] conn : connections) {
            graph.putIfAbsent(conn[0], new ArrayList<>());
            graph.putIfAbsent(conn[1], new ArrayList<>());
            graph.get(conn[0]).add(new int[]{conn[1], 1});
            graph.get(conn[1]).add(new int[]{conn[0], 0});
        }

        boolean[] visited = new boolean[n];
        return dfs(0, graph, visited);
    }

    private int dfs(int node, Map<Integer, List<int[]>> graph, boolean[] visited) {
        visited[node] = true;
        int count = 0;
        for (int[] neighbor : graph.get(node)) {
            if (!visited[neighbor[0]]) {
                count += neighbor[1] + dfs(neighbor[0], graph, visited);
            }
        }
        return count;
    }
}