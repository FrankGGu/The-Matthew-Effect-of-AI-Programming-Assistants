public class Solution {

import java.util.*;

public class Solution {
    public int largestColorValue(String s, int[][] edges) {
        int n = s.length();
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
        }

        int[][] colorCount = new int[n][26];
        boolean[] visited = new boolean[n];
        boolean[] recursionStack = new boolean[n];
        int[] maxColorValue = {0};

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                dfs(i, graph, s, colorCount, visited, recursionStack, maxColorValue);
            }
        }

        return maxColorValue[0];
    }

    private void dfs(int node, List<List<Integer>> graph, String s, int[][] colorCount, boolean[] visited, boolean[] recursionStack, int[] maxColorValue) {
        visited[node] = true;
        recursionStack[node] = true;

        int currentColor = s.charAt(node) - 'a';
        colorCount[node][currentColor] = 1;

        for (int neighbor : graph.get(node)) {
            if (recursionStack[neighbor]) {
                throw new RuntimeException("Cycle detected");
            }
            if (!visited[neighbor]) {
                dfs(neighbor, graph, s, colorCount, visited, recursionStack, maxColorValue);
            }

            for (int i = 0; i < 26; i++) {
                colorCount[node][i] = Math.max(colorCount[node][i], colorCount[neighbor][i]);
            }
        }

        recursionStack[node] = false;
        maxColorValue[0] = Math.max(maxColorValue[0], colorCount[node][currentColor]);
    }
}
}