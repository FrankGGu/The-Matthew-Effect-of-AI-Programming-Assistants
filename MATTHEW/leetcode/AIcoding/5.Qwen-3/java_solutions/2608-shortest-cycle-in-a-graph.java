public class Solution {

import java.util.*;

public class Solution {
    public int shortestCycleLength(int n, int[][] edges) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        int minCycle = Integer.MAX_VALUE;

        for (int start = 0; start < n; start++) {
            int[] dist = new int[n];
            Arrays.fill(dist, -1);
            Queue<Integer> queue = new LinkedList<>();
            queue.add(start);
            dist[start] = 0;

            while (!queue.isEmpty()) {
                int node = queue.poll();
                for (int neighbor : graph.get(node)) {
                    if (dist[neighbor] == -1) {
                        dist[neighbor] = dist[node] + 1;
                        queue.add(neighbor);
                    } else if (dist[neighbor] >= dist[node]) {
                        minCycle = Math.min(minCycle, dist[node] + dist[neighbor] + 1);
                    }
                }
            }
        }

        return minCycle == Integer.MAX_VALUE ? -1 : minCycle;
    }
}
}