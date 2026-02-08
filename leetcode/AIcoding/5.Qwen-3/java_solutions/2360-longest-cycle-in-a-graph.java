public class Solution {

import java.util.*;

public class Solution {
    public int longestCycle(int n, int[] edges) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int i = 0; i < edges.length; i += 2) {
            int u = edges[i];
            int v = edges[i + 1];
            graph.get(u).add(v);
        }

        boolean[] visited = new boolean[n];
        int maxCycle = -1;

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                Map<Integer, Integer> timeMap = new HashMap<>();
                int time = 0;
                int current = i;
                while (current != -1 && !visited[current]) {
                    visited[current] = true;
                    timeMap.put(current, time++);
                    current = graph.get(current).isEmpty() ? -1 : graph.get(current).get(0);
                }
                if (current != -1 && timeMap.containsKey(current)) {
                    int cycleLength = timeMap.get(current);
                    maxCycle = Math.max(maxCycle, time - cycleLength);
                }
            }
        }
        return maxCycle;
    }
}
}