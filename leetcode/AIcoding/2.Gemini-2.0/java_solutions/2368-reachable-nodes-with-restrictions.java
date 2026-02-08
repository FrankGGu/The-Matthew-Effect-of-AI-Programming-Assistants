import java.util.*;

class Solution {
    public int reachableNodes(int n, int[][] edges, int[] restricted) {
        Set<Integer> restrictedSet = new HashSet<>();
        for (int r : restricted) {
            restrictedSet.add(r);
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
        queue.offer(0);
        Set<Integer> visited = new HashSet<>();
        visited.add(0);
        int count = 0;

        while (!queue.isEmpty()) {
            int u = queue.poll();
            count++;

            for (int v : adj.get(u)) {
                if (!visited.contains(v) && !restrictedSet.contains(v)) {
                    queue.offer(v);
                    visited.add(v);
                }
            }
        }

        return count;
    }
}