public class Solution {
    public int closestNode(int n, int[][] edges, int node1, int node2) {
        int[] dist1 = bfs(n, edges, node1);
        int[] dist2 = bfs(n, edges, node2);

        int result = 0;
        int minDist = Integer.MAX_VALUE;

        for (int i = 0; i < n; i++) {
            int currentDist = Math.max(dist1[i], dist2[i]);
            if (currentDist < minDist) {
                minDist = currentDist;
                result = i;
            }
        }

        return result;
    }

    private int[] bfs(int n, int[][] edges, int start) {
        int[] dist = new int[n];
        Arrays.fill(dist, -1);
        Queue<Integer> queue = new LinkedList<>();
        queue.add(start);
        dist[start] = 0;

        while (!queue.isEmpty()) {
            int node = queue.poll();
            for (int[] edge : edges) {
                int u = edge[0];
                int v = edge[1];
                if (u == node && dist[v] == -1) {
                    dist[v] = dist[u] + 1;
                    queue.add(v);
                } else if (v == node && dist[u] == -1) {
                    dist[u] = dist[v] + 1;
                    queue.add(u);
                }
            }
        }

        return dist;
    }
}