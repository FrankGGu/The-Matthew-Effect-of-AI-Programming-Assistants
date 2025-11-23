public class Solution {

import java.util.*;

public class FrogPositionAfterTSeconds {
    public int frogPosition(int n, int[][] edges, int t, int target) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (int[] edge : edges) {
            graph.computeIfAbsent(edge[0], k -> new ArrayList<>()).add(edge[1]);
            graph.computeIfAbsent(edge[1], k -> new ArrayList<>()).add(edge[0]);
        }

        boolean[] visited = new boolean[n + 1];
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{1, 0, 1}); // node, time, probability

        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            int node = current[0];
            int time = current[1];
            int prob = current[2];

            if (time == t) {
                return node == target ? prob : 0;
            }

            visited[node] = true;
            int children = 0;
            for (int neighbor : graph.getOrDefault(node, Collections.emptyList())) {
                if (!visited[neighbor]) {
                    children++;
                }
            }

            if (children == 0) {
                return node == target ? prob : 0;
            }

            for (int neighbor : graph.getOrDefault(node, Collections.emptyList())) {
                if (!visited[neighbor]) {
                    queue.offer(new int[]{neighbor, time + 1, prob / children});
                }
            }
        }

        return 0;
    }
}
}