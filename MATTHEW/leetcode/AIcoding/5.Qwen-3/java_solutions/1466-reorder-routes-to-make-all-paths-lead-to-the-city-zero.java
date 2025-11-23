public class Solution {

import java.util.*;

public class Solution {
    public int minReorder(int n, int[][] connections) {
        List<List<int[]>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] conn : connections) {
            int u = conn[0];
            int v = conn[1];
            graph.get(u).add(new int[]{v, 1});
            graph.get(v).add(new int[]{u, 0});
        }

        boolean[] visited = new boolean[n];
        return dfs(0, -1, graph, visited);
    }

    private int dfs(int node, int parent, List<List<int[]>> graph, boolean[] visited) {
        visited[node] = true;
        int count = 0;
        for (int[] neighbor : graph.get(node)) {
            int nextNode = neighbor[0];
            int direction = neighbor[1];
            if (!visited[nextNode]) {
                if (direction == 1) {
                    count++;
                }
                count += dfs(nextNode, node, graph, visited);
            }
        }
        return count;
    }
}
}