public class Solution {

import java.util.*;

public class Solution {
    public int idleTime(int n, int[][] edges, int[] patience) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        int[] dist = new int[n];
        Arrays.fill(dist, -1);
        Queue<Integer> queue = new LinkedList<>();
        queue.add(0);
        dist[0] = 0;

        while (!queue.isEmpty()) {
            int node = queue.poll();
            for (int neighbor : graph.get(node)) {
                if (dist[neighbor] == -1) {
                    dist[neighbor] = dist[node] + 1;
                    queue.add(neighbor);
                }
            }
        }

        int maxTime = 0;
        for (int i = 1; i < n; i++) {
            int d = dist[i];
            int time = 2 * d;
            if (patience[i] < time) {
                time += (time - 1) / patience[i] * patience[i];
            }
            maxTime = Math.max(maxTime, time);
        }

        return maxTime;
    }
}
}