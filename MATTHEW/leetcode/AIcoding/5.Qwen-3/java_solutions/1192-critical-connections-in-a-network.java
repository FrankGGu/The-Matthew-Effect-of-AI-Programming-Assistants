public class Solution {

import java.util.*;

public class Solution {
    List<List<Integer>> result = new ArrayList<>();
    int[] disc;
    int[] low;
    int time = 0;
    boolean[] visited;

    public List<List<Integer>> criticalConnections(int n, List<List<Integer>> connections) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (List<Integer> conn : connections) {
            graph.putIfAbsent(conn.get(0), new ArrayList<>());
            graph.putIfAbsent(conn.get(1), new ArrayList<>());
            graph.get(conn.get(0)).add(conn.get(1));
            graph.get(conn.get(1)).add(conn.get(0));
        }

        disc = new int[n];
        low = new int[n];
        visited = new boolean[n];

        Arrays.fill(disc, -1);
        Arrays.fill(low, -1);

        for (int i = 0; i < n; i++) {
            if (disc[i] == -1) {
                dfs(i, -1, graph);
            }
        }

        return result;
    }

    private void dfs(int node, int parent, Map<Integer, List<Integer>> graph) {
        visited[node] = true;
        disc[node] = time;
        low[node] = time;
        time++;

        for (int neighbor : graph.getOrDefault(node, new ArrayList<>())) {
            if (neighbor == parent) continue;
            if (!visited[neighbor]) {
                dfs(neighbor, node, graph);
                low[node] = Math.min(low[node], low[neighbor]);
                if (low[neighbor] > disc[node]) {
                    result.add(Arrays.asList(node, neighbor));
                }
            } else {
                low[node] = Math.min(low[node], disc[neighbor]);
            }
        }
    }
}
}