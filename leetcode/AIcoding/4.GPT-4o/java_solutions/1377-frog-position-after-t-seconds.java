import java.util.*;

public class Solution {
    public double frogPosition(int n, int[][] edges, int t, int target) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (int[] edge : edges) {
            graph.computeIfAbsent(edge[0], k -> new ArrayList<>()).add(edge[1]);
            graph.computeIfAbsent(edge[1], k -> new ArrayList<>()).add(edge[0]);
        }

        return dfs(graph, 1, target, t, new boolean[n + 1], 0);
    }

    private double dfs(Map<Integer, List<Integer>> graph, int current, int target, int t, boolean[] visited, int depth) {
        if (depth > t) return 0.0;
        if (current == target && (depth == t || graph.get(current).size() == 1)) return 1.0;

        visited[current] = true;
        List<Integer> neighbors = graph.get(current);
        double probability = 0.0;
        int count = 0;

        for (int neighbor : neighbors) {
            if (!visited[neighbor]) {
                count++;
                probability += dfs(graph, neighbor, target, t, visited, depth + 1);
            }
        }

        visited[current] = false;
        return count == 0 ? (current == target ? 1.0 : 0.0) : probability / count;
    }
}