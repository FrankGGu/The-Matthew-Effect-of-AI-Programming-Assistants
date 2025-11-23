import java.util.*;

class Solution {
    public List<List<Integer>> findTheEdges(int n, int[][] edges, int source, int destination) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        int[] dist = new int[n];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[source] = 0;
        Queue<Integer> q = new LinkedList<>();
        q.offer(source);
        int[] parent = new int[n];
        Arrays.fill(parent, -1);

        while (!q.isEmpty()) {
            int u = q.poll();
            for (int v : adj.get(u)) {
                if (dist[v] > dist[u] + 1) {
                    dist[v] = dist[u] + 1;
                    parent[v] = u;
                    q.offer(v);
                }
            }
        }

        if (dist[destination] == Integer.MAX_VALUE) {
            return new ArrayList<>();
        }

        List<List<Integer>> shortestPathEdges = new ArrayList<>();
        Set<String> shortestPathEdgesSet = new HashSet<>();

        Queue<List<Integer>> paths = new LinkedList<>();
        paths.offer(List.of(destination));

        while (!paths.isEmpty()) {
            List<Integer> path = paths.poll();
            int u = path.get(0);

            if (u == source) {
                for (int i = 0; i < path.size() - 1; i++) {
                    int node1 = path.get(i);
                    int node2 = path.get(i + 1);
                    int minNode = Math.min(node1, node2);
                    int maxNode = Math.max(node1, node2);
                    shortestPathEdgesSet.add(minNode + "-" + maxNode);
                }
                continue;
            }

            for (int i = 0; i < n; i++) {
                if (parent[u] == i && dist[u] == dist[i] + 1) {
                    List<Integer> newPath = new ArrayList<>(path);
                    newPath.add(0, i);
                    paths.offer(newPath);
                }
            }
        }

        for (int[] edge : edges) {
            int node1 = edge[0];
            int node2 = edge[1];
            int minNode = Math.min(node1, node2);
            int maxNode = Math.max(node1, node2);
            if (shortestPathEdgesSet.contains(minNode + "-" + maxNode)) {
                shortestPathEdges.add(Arrays.asList(edge[0], edge[1]));
            }
        }

        return shortestPathEdges;
    }
}