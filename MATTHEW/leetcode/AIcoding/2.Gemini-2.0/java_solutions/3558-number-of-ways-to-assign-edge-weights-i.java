import java.util.*;

class Solution {
    public int minOperations(int n, int[][] edges, int startNode, int endNode) {
        if (startNode == endNode) {
            return 0;
        }

        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj.get(u).add(v);
            adj.get(v).add(u);
        }

        Queue<Integer> queue = new LinkedList<>();
        queue.offer(startNode);
        Set<Integer> visited = new HashSet<>();
        visited.add(startNode);

        int operations = 0;
        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int u = queue.poll();
                if (u == endNode) {
                    return operations;
                }
                for (int v : adj.get(u)) {
                    if (!visited.contains(v)) {
                        visited.add(v);
                        queue.offer(v);
                    }
                }
            }
            operations++;
        }

        return -1;
    }
}