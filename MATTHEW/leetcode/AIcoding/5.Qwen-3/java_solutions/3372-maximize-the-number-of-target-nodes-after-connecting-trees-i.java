public class Solution {

import java.util.*;

public class Solution {
    public int connectTrees(int n, int[][] edges, int x, int y) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        boolean[] visited = new boolean[n];
        int[] size = new int[n];
        dfs(0, graph, visited, size);

        int totalNodes = size[0];
        int[] subtreeSize = new int[n];
        boolean[] isXSubtree = new boolean[n];
        boolean[] isYSubtree = new boolean[n];

        visited = new boolean[n];
        dfs2(0, graph, visited, subtreeSize, isXSubtree, x);
        visited = new boolean[n];
        dfs2(0, graph, visited, subtreeSize, isYSubtree, y);

        int result = 0;
        for (int i = 0; i < n; i++) {
            if (isXSubtree[i] && isYSubtree[i]) {
                result += subtreeSize[i];
            }
        }

        return result;
    }

    private int dfs(int node, List<List<Integer>> graph, boolean[] visited, int[] size) {
        visited[node] = true;
        int total = 1;
        for (int neighbor : graph.get(node)) {
            if (!visited[neighbor]) {
                total += dfs(neighbor, graph, visited, size);
            }
        }
        size[node] = total;
        return total;
    }

    private void dfs2(int node, List<List<Integer>> graph, boolean[] visited, int[] subtreeSize, boolean[] isTarget, int target) {
        visited[node] = true;
        subtreeSize[node] = 1;
        for (int neighbor : graph.get(node)) {
            if (!visited[neighbor]) {
                dfs2(neighbor, graph, visited, subtreeSize, isTarget, target);
                subtreeSize[node] += subtreeSize[neighbor];
            }
        }
        isTarget[node] = (node == target || (subtreeSize[node] > 1 && isTarget[0]));
    }
}
}