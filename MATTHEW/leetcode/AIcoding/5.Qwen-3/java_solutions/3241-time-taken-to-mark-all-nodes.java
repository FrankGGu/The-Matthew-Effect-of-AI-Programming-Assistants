public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> timeTakenToMarkAllNodes(int n, int[][] edges) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            graph.get(u).add(v);
            graph.get(v).add(u);
        }

        List<Integer> result = new ArrayList<>();
        boolean[] visited = new boolean[n];
        int[] time = new int[1];

        dfs(0, graph, visited, time, result);

        return result;
    }

    private void dfs(int node, List<List<Integer>> graph, boolean[] visited, int[] time, List<Integer> result) {
        visited[node] = true;
        time[0]++;
        result.add(time[0]);

        for (int neighbor : graph.get(node)) {
            if (!visited[neighbor]) {
                dfs(neighbor, graph, visited, time, result);
            }
        }
    }
}
}