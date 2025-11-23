public class Solution {

import java.util.*;

class Graph {
    private Map<Integer, List<int[]>> graph;
    private int nodes;

    public Graph(int n, int[][] edges) {
        graph = new HashMap<>();
        nodes = n;
        for (int[] edge : edges) {
            graph.putIfAbsent(edge[0], new ArrayList<>());
            graph.get(edge[0]).add(new int[]{edge[1], edge[2]});
        }
    }

    public void addEdge(int[] edge) {
        graph.putIfAbsent(edge[0], new ArrayList<>());
        graph.get(edge[0]).add(new int[]{edge[1], edge[2]});
    }

    public int shortestPath(int s, int t) {
        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[1]));
        pq.offer(new int[]{s, 0});
        Set<Integer> visited = new HashSet<>();

        while (!pq.isEmpty()) {
            int[] current = pq.poll();
            int node = current[0];
            int dist = current[1];

            if (node == t) {
                return dist;
            }

            if (visited.contains(node)) {
                continue;
            }

            visited.add(node);

            if (graph.containsKey(node)) {
                for (int[] neighbor : graph.get(node)) {
                    int nextNode = neighbor[0];
                    int weight = neighbor[1];
                    pq.offer(new int[]{nextNode, dist + weight});
                }
            }
        }

        return -1;
    }
}
}