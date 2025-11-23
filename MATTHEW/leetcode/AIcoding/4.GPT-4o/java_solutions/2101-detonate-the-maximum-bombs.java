import java.util.*;

class Solution {
    public int maximumDetonations(int[][] bombs) {
        int n = bombs.length;
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
            for (int j = 0; j < n; j++) {
                if (i != j && canDetonate(bombs[i], bombs[j])) {
                    graph.get(i).add(j);
                }
            }
        }

        int maxDetonations = 0;
        for (int i = 0; i < n; i++) {
            boolean[] visited = new boolean[n];
            maxDetonations = Math.max(maxDetonations, dfs(i, graph, visited));
        }

        return maxDetonations;
    }

    private boolean canDetonate(int[] bomb1, int[] bomb2) {
        long distance = (long) (bomb1[0] - bomb2[0]) * (bomb1[0] - bomb2[0]) + 
                        (long) (bomb1[1] - bomb2[1]) * (bomb1[1] - bomb2[1]);
        long radius = (long) bomb1[2] * bomb1[2];
        return distance <= radius;
    }

    private int dfs(int index, List<List<Integer>> graph, boolean[] visited) {
        visited[index] = true;
        int count = 1;
        for (int neighbor : graph.get(index)) {
            if (!visited[neighbor]) {
                count += dfs(neighbor, graph, visited);
            }
        }
        return count;
    }
}