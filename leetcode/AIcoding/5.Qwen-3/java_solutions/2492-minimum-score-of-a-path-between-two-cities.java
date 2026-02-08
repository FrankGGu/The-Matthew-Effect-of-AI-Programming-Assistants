public class Solution {

import java.util.*;

public class Solution {
    public int minScore(int n, int[][] roads) {
        Map<Integer, List<int[]>> graph = new HashMap<>();
        for (int[] road : roads) {
            graph.putIfAbsent(road[0], new ArrayList<>());
            graph.putIfAbsent(road[1], new ArrayList<>());
            graph.get(road[0]).add(new int[]{road[1], road[2]});
            graph.get(road[1]).add(new int[]{road[0], road[2]});
        }

        boolean[] visited = new boolean[n + 1];
        int minScore = Integer.MAX_VALUE;

        Queue<Integer> queue = new LinkedList<>();
        queue.add(1);
        visited[1] = true;

        while (!queue.isEmpty()) {
            int node = queue.poll();
            for (int[] neighbor : graph.getOrDefault(node, new ArrayList<>())) {
                minScore = Math.min(minScore, neighbor[1]);
                if (!visited[neighbor[0]]) {
                    visited[neighbor[0]] = true;
                    queue.add(neighbor[0]);
                }
            }
        }

        return minScore;
    }
}
}