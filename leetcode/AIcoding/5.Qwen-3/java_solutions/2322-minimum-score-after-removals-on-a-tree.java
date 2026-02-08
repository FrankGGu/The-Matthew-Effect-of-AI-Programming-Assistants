public class Solution {

import java.util.*;

public class Solution {
    public int minScore(int n, int[][] edges) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        int[] parent = new int[n];
        Arrays.fill(parent, -1);
        boolean[] visited = new boolean[n];
        Queue<Integer> queue = new LinkedList<>();
        queue.add(0);
        visited[0] = true;

        while (!queue.isEmpty()) {
            int node = queue.poll();
            for (int neighbor : graph.get(node)) {
                if (!visited[neighbor]) {
                    visited[neighbor] = true;
                    parent[neighbor] = node;
                    queue.add(neighbor);
                }
            }
        }

        Map<Integer, Integer> count = new HashMap<>();
        for (int i = 0; i < n; i++) {
            count.put(i, 1);
        }

        for (int i = 1; i < n; i++) {
            count.put(parent[i], count.get(parent[i]) + 1);
        }

        int total = n;
        int minScore = Integer.MAX_VALUE;
        for (int i = 1; i < n; i++) {
            int size = count.get(i);
            int other = total - size;
            minScore = Math.min(minScore, Math.min(size, other));
        }

        return minScore;
    }
}
}