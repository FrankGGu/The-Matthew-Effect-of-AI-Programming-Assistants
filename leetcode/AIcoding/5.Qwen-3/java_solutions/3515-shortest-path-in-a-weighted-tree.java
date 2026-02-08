public class Solution {

import java.util.*;

public class Solution {
    public int shortestPath(int[][] edges, int n, int source, int destination) {
        Map<Integer, List<int[]>> graph = new HashMap<>();
        for (int[] edge : edges) {
            graph.putIfAbsent(edge[0], new ArrayList<>());
            graph.get(edge[0]).add(new int[]{edge[1], edge[2]});
            graph.putIfAbsent(edge[1], new ArrayList<>());
            graph.get(edge[1]).add(new int[]{edge[0], edge[2]});
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[1]));
        pq.offer(new int[]{source, 0});
        Set<Integer> visited = new HashSet<>();

        while (!pq.isEmpty()) {
            int[] current = pq.poll();
            int node = current[0];
            int dist = current[1];

            if (node == destination) {
                return dist;
            }

            if (visited.contains(node)) {
                continue;
            }

            visited.add(node);

            for (int[] neighbor : graph.getOrDefault(node, new ArrayList<>())) {
                int nextNode = neighbor[0];
                int weight = neighbor[1];
                pq.offer(new int[]{nextNode, dist + weight});
            }
        }

        return -1;
    }
}
}