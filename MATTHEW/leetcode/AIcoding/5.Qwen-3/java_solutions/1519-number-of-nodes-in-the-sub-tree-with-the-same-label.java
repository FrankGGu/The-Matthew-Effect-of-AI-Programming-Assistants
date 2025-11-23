public class Solution {

import java.util.*;

public class Solution {
    public int[] countSubTrees(int n, int[] edges, String labels) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; ++i) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        int[] result = new int[n];
        boolean[] visited = new boolean[n];
        dfs(0, graph, labels, visited, result);
        return result;
    }

    private int[] dfs(int node, List<List<Integer>> graph, String labels, boolean[] visited, int[] result) {
        visited[node] = true;
        int[] count = new int[26];
        for (int neighbor : graph.get(node)) {
            if (!visited[neighbor]) {
                int[] childCount = dfs(neighbor, graph, labels, visited, result);
                for (int i = 0; i < 26; ++i) {
                    count[i] += childCount[i];
                }
            }
        }
        int labelIndex = labels.charAt(node) - 'a';
        count[labelIndex]++;
        result[node] = count[labelIndex];
        return count;
    }
}
}