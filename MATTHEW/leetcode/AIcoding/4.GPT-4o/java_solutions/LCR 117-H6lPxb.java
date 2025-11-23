import java.util.*;

public class Solution {
    public int numSimilarGroups(String[] strs) {
        int n = strs.length;
        boolean[][] graph = new boolean[n][n];

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (isSimilar(strs[i], strs[j])) {
                    graph[i][j] = graph[j][i] = true;
                }
            }
        }

        boolean[] visited = new boolean[n];
        int count = 0;

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                count++;
                dfs(graph, visited, i);
            }
        }

        return count;
    }

    private void dfs(boolean[][] graph, boolean[] visited, int node) {
        visited[node] = true;
        for (int i = 0; i < graph.length; i++) {
            if (graph[node][i] && !visited[i]) {
                dfs(graph, visited, i);
            }
        }
    }

    private boolean isSimilar(String a, String b) {
        int count = 0;
        for (int i = 0; i < a.length(); i++) {
            if (a.charAt(i) != b.charAt(i)) {
                count++;
                if (count > 2) return false;
            }
        }
        return count == 2 || count == 0;
    }
}