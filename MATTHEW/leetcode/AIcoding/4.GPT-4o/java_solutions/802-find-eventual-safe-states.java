import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<Integer> eventualSafeNodes(int[][] graph) {
        int n = graph.length;
        int[] status = new int[n];
        List<Integer> safeNodes = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            if (dfs(graph, i, status)) {
                safeNodes.add(i);
            }
        }

        return safeNodes;
    }

    private boolean dfs(int[][] graph, int node, int[] status) {
        if (status[node] != 0) {
            return status[node] == 2;
        }

        status[node] = 1;
        for (int next : graph[node]) {
            if (!dfs(graph, next, status)) {
                return false;
            }
        }

        status[node] = 2;
        return true;
    }
}