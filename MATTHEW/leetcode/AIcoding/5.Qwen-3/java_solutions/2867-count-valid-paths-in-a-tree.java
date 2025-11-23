public class Solution {

import java.util.*;

public class Solution {
    public int countValidPaths(int n, int[][] roads) {
        List<List<int[]>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] road : roads) {
            int u = road[0], v = road[1], time = road[2];
            graph.get(u).add(new int[]{v, time});
            graph.get(v).add(new int[]{u, time});
        }

        int[] result = {0};

        for (int i = 0; i < n; i++) {
            boolean[] visited = new boolean[n];
            dfs(i, -1, visited, graph, 0, result);
        }

        return result[0];
    }

    private void dfs(int node, int parent, boolean[] visited, List<List<int[]>> graph, int time, int[] result) {
        visited[node] = true;
        boolean isLeaf = true;
        for (int[] neighbor : graph.get(node)) {
            int nextNode = neighbor[0], nextTime = neighbor[1];
            if (!visited[nextNode]) {
                isLeaf = false;
                dfs(nextNode, node, visited, graph, time + nextTime, result);
            }
        }
        if (isLeaf) {
            result[0]++;
        }
        visited[node] = false;
    }
}
}