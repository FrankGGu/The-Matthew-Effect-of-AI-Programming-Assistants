public class Solution {

import java.util.*;

public class Solution {
    public int[] loudAndRich(int[][] richer, int[] quiet) {
        int n = quiet.length;
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        int[] inDegree = new int[n];

        for (int[] edge : richer) {
            int u = edge[0];
            int v = edge[1];
            graph.get(v).add(u);
            inDegree[u]++;
        }

        Queue<Integer> queue = new LinkedList<>();
        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            result[i] = i;
            if (inDegree[i] == 0) {
                queue.offer(i);
            }
        }

        while (!queue.isEmpty()) {
            int current = queue.poll();
            for (int neighbor : graph.get(current)) {
                if (quiet[result[neighbor]] > quiet[result[current]]) {
                    result[neighbor] = result[current];
                }
                inDegree[neighbor]--;
                if (inDegree[neighbor] == 0) {
                    queue.offer(neighbor);
                }
            }
        }

        return result;
    }
}
}