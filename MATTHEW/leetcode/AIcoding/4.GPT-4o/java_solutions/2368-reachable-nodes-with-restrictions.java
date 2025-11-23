import java.util.*;

public class Solution {
    public int reachableNodes(int[][] edges, int maxMoves, int n) {
        Map<Integer, List<int[]>> graph = new HashMap<>();
        for (int[] edge : edges) {
            graph.putIfAbsent(edge[0], new ArrayList<>());
            graph.putIfAbsent(edge[1], new ArrayList<>());
            graph.get(edge[0]).add(new int[]{edge[1], edge[2]});
            graph.get(edge[1]).add(new int[]{edge[0], edge[2]});
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[1]));
        pq.offer(new int[]{0, 0});
        int reachableNodes = 0;
        Map<Integer, Integer> visited = new HashMap<>();

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int node = curr[0];
            int movesUsed = curr[1];

            if (movesUsed > maxMoves) continue;
            reachableNodes++;
            visited.put(node, movesUsed);

            for (int[] neighbor : graph.getOrDefault(node, new ArrayList<>())) {
                int nextNode = neighbor[0];
                int edgeWeight = neighbor[1];
                int newMoves = movesUsed + edgeWeight + 1;

                if (newMoves <= maxMoves) {
                    if (!visited.containsKey(nextNode) || visited.get(nextNode) > newMoves) {
                        pq.offer(new int[]{nextNode, newMoves});
                    }
                }

                int remainingNodes = Math.max(0, maxMoves - movesUsed - 1);
                if (remainingNodes > 0) {
                    reachableNodes += Math.min(edgeWeight, remainingNodes);
                }
            }
        }

        return reachableNodes;
    }
}