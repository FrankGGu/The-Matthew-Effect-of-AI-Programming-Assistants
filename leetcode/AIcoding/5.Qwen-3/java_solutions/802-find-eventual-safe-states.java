public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> eventualSafeStates(int[][] graph) {
        int n = graph.length;
        int[] color = new int[n];

        List<Integer> result = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            if (isSafe(graph, i, color)) {
                result.add(i);
            }
        }

        return result;
    }

    private boolean isSafe(int[][] graph, int node, int[] color) {
        if (color[node] == 1) {
            return false;
        }
        if (color[node] == 2) {
            return true;
        }

        color[node] = 1;

        for (int neighbor : graph[node]) {
            if (!isSafe(graph, neighbor, color)) {
                return false;
            }
        }

        color[node] = 2;
        return true;
    }
}
}