public class Solution {

import java.util.*;

public class Solution {
    public int maximumDetonation(int[][] bombs) {
        int n = bombs.length;
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (i != j) {
                    long dx = bombs[i][0] - bombs[j][0];
                    long dy = bombs[i][1] - bombs[j][1];
                    long distanceSq = dx * dx + dy * dy;
                    long radiusSq = (long) bombs[i][2] * bombs[i][2];
                    if (distanceSq <= radiusSq) {
                        graph.get(i).add(j);
                    }
                }
            }
        }

        int max = 0;
        for (int i = 0; i < n; i++) {
            Set<Integer> visited = new HashSet<>();
            dfs(i, graph, visited);
            max = Math.max(max, visited.size());
        }

        return max;
    }

    private void dfs(int node, List<List<Integer>> graph, Set<Integer> visited) {
        if (visited.contains(node)) {
            return;
        }
        visited.add(node);
        for (int neighbor : graph.get(node)) {
            dfs(neighbor, graph, visited);
        }
    }
}
}