import java.util.*;

class Solution {
    public int minimumCost(int n, int[][] roads) {
        Map<Integer, List<int[]>> graph = new HashMap<>();
        for (int[] road : roads) {
            graph.putIfAbsent(road[0], new ArrayList<>());
            graph.putIfAbsent(road[1], new ArrayList<>());
            graph.get(road[0]).add(new int[]{road[1], road[2]});
            graph.get(road[1]).add(new int[]{road[0], road[2]});
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[1]));
        pq.offer(new int[]{1, 0});
        boolean[] visited = new boolean[n + 1];
        int totalCost = 0;

        while (!pq.isEmpty()) {
            int[] current = pq.poll();
            int node = current[0], cost = current[1];

            if (visited[node]) continue;
            visited[node] = true;
            totalCost += cost;

            for (int[] neighbor : graph.getOrDefault(node, new ArrayList<>())) {
                if (!visited[neighbor[0]]) {
                    pq.offer(new int[]{neighbor[0], neighbor[1]});
                }
            }
        }

        for (boolean v : visited) {
            if (!v) return -1;
        }

        return totalCost;
    }
}