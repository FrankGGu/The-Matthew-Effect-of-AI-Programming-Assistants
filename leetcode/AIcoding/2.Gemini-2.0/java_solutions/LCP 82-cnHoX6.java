import java.util.*;

class Solution {
    public int treeDiameter(int[][] edges) {
        int n = 0;
        for (int[] edge : edges) {
            n = Math.max(n, Math.max(edge[0], edge[1]));
        }
        n++;

        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        int[] farthestNode = bfs(0, adj);
        farthestNode = bfs(farthestNode[0], adj);

        return farthestNode[1];
    }

    private int[] bfs(int startNode, List<List<Integer>> adj) {
        int n = adj.size();
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(startNode);

        int[] dist = new int[n];
        Arrays.fill(dist, -1);
        dist[startNode] = 0;

        int farthestNode = startNode;
        int maxDist = 0;

        while (!queue.isEmpty()) {
            int u = queue.poll();

            for (int v : adj.get(u)) {
                if (dist[v] == -1) {
                    dist[v] = dist[u] + 1;
                    queue.offer(v);

                    if (dist[v] > maxDist) {
                        maxDist = dist[v];
                        farthestNode = v;
                    }
                }
            }
        }

        return new int[] {farthestNode, maxDist};
    }
}