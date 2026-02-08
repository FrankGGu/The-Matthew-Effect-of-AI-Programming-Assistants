import java.util.*;

public class Solution {
    public List<int[]> findEdges(int n, int[][] edges, int[][] paths) {
        List<int[]> result = new ArrayList<>();
        Map<Integer, List<int[]>> graph = new HashMap<>();

        for (int[] edge : edges) {
            graph.putIfAbsent(edge[0], new ArrayList<>());
            graph.putIfAbsent(edge[1], new ArrayList<>());
            graph.get(edge[0]).add(new int[]{edge[1], edge[2]});
            graph.get(edge[1]).add(new int[]{edge[0], edge[2]});
        }

        for (int[] path : paths) {
            Set<Integer> visited = new HashSet<>();
            PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[1]));
            pq.add(new int[]{path[0], 0});
            Map<Integer, Integer> minCost = new HashMap<>();
            while (!pq.isEmpty()) {
                int[] current = pq.poll();
                int node = current[0], cost = current[1];
                if (visited.contains(node)) continue;
                visited.add(node);
                minCost.put(node, cost);
                for (int[] neighbor : graph.getOrDefault(node, new ArrayList<>())) {
                    if (!visited.contains(neighbor[0])) {
                        pq.add(new int[]{neighbor[0], cost + neighbor[1]});
                    }
                }
            }
            for (int i = 0; i < path.length - 1; i++) {
                int u = path[i], v = path[i + 1];
                for (int[] neighbor : graph.get(u)) {
                    if (neighbor[0] == v && minCost.get(u) + neighbor[1] == minCost.get(v)) {
                        result.add(new int[]{u, v});
                        break;
                    }
                }
            }
        }

        return result;
    }
}