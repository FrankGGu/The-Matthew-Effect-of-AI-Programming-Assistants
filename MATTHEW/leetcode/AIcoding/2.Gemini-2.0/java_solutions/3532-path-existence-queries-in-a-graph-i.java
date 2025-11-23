import java.util.*;

class Solution {
    public List<Boolean> pathExistence(int n, int[][] edges, List<List<Integer>> queries) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        List<Boolean> result = new ArrayList<>();
        for (List<Integer> query : queries) {
            int start = query.get(0);
            int end = query.get(1);
            result.add(hasPath(n, adj, start, end));
        }

        return result;
    }

    private boolean hasPath(int n, List<List<Integer>> adj, int start, int end) {
        Queue<Integer> queue = new LinkedList<>();
        boolean[] visited = new boolean[n + 1];

        queue.offer(start);
        visited[start] = true;

        while (!queue.isEmpty()) {
            int node = queue.poll();

            if (node == end) {
                return true;
            }

            for (int neighbor : adj.get(node)) {
                if (!visited[neighbor]) {
                    visited[neighbor] = true;
                    queue.offer(neighbor);
                }
            }
        }

        return false;
    }
}