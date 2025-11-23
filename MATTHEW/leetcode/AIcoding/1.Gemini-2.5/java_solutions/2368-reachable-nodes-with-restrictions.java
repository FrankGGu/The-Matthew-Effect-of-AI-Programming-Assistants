import java.util.*;

class Solution {
    public int reachableNodes(int n, int[][] edges, int[] restricted) {
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

        Set<Integer> restrictedSet = new HashSet<>();
        for (int node : restricted) {
            restrictedSet.add(node);
        }

        if (restrictedSet.contains(0)) {
            return 0;
        }

        Queue<Integer> queue = new LinkedList<>();
        boolean[] visited = new boolean[n];
        int reachableCount = 0;

        queue.offer(0);
        visited[0] = true;
        reachableCount++;

        while (!queue.isEmpty()) {
            int curr = queue.poll();

            for (int neighbor : adj.get(curr)) {
                if (!visited[neighbor] && !restrictedSet.contains(neighbor)) {
                    visited[neighbor] = true;
                    queue.offer(neighbor);
                    reachableCount++;
                }
            }
        }

        return reachableCount;
    }
}