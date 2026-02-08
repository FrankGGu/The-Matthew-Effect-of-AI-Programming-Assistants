import java.util.*;

class Solution {
    public int findShortestCycle(int n, int[][] edges) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        int shortestCycle = Integer.MAX_VALUE;

        for (int start = 0; start < n; start++) {
            Queue<int[]> queue = new LinkedList<>();
            boolean[] visited = new boolean[n];
            int[] dist = new int[n];
            Arrays.fill(dist, -1);
            queue.offer(new int[]{start, -1});
            visited[start] = true;
            dist[start] = 0;

            while (!queue.isEmpty()) {
                int[] curr = queue.poll();
                int node = curr[0];
                int parent = curr[1];

                for (int neighbor : graph.get(node)) {
                    if (!visited[neighbor]) {
                        visited[neighbor] = true;
                        dist[neighbor] = dist[node] + 1;
                        queue.offer(new int[]{neighbor, node});
                    } else if (neighbor != parent) {
                        shortestCycle = Math.min(shortestCycle, dist[node] + 1 + dist[neighbor] + 1);
                    }
                }
            }
        }

        return shortestCycle == Integer.MAX_VALUE ? -1 : shortestCycle;
    }
}