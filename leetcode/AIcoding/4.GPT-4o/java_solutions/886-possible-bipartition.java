import java.util.*;

class Solution {
    public boolean possibleBipartition(int n, int[][] dislikes) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : dislikes) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        int[] color = new int[n + 1];
        Arrays.fill(color, -1);

        for (int i = 1; i <= n; i++) {
            if (color[i] == -1) {
                if (!bipartiteDFS(graph, color, i, 0)) {
                    return false;
                }
            }
        }
        return true;
    }

    private boolean bipartiteDFS(List<List<Integer>> graph, int[] color, int node, int c) {
        color[node] = c;
        for (int neighbor : graph.get(node)) {
            if (color[neighbor] == -1) {
                if (!bipartiteDFS(graph, color, neighbor, 1 - c)) {
                    return false;
                }
            } else if (color[neighbor] == c) {
                return false;
            }
        }
        return true;
    }
}