import java.util.Arrays;
import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public int closestMeetingNode(int[] edges, int node1, int node2) {
        int n = edges.length;
        int[] dist1 = new int[n];
        int[] dist2 = new int[n];
        Arrays.fill(dist1, Integer.MAX_VALUE);
        Arrays.fill(dist2, Integer.MAX_VALUE);

        bfs(node1, edges, dist1);
        bfs(node2, edges, dist2);

        int minDist = Integer.MAX_VALUE;
        int ans = -1;
        for (int i = 0; i < n; i++) {
            if (dist1[i] != Integer.MAX_VALUE && dist2[i] != Integer.MAX_VALUE) {
                int maxDist = Math.max(dist1[i], dist2[i]);
                if (maxDist < minDist) {
                    minDist = maxDist;
                    ans = i;
                }
            }
        }

        return ans;
    }

    private void bfs(int startNode, int[] edges, int[] dist) {
        int n = edges.length;
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(startNode);
        dist[startNode] = 0;

        while (!queue.isEmpty()) {
            int u = queue.poll();
            int v = edges[u];

            if (v != -1 && dist[v] == Integer.MAX_VALUE) {
                dist[v] = dist[u] + 1;
                queue.offer(v);
            }
        }
    }
}