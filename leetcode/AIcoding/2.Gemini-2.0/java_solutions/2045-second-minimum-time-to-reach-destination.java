import java.util.*;

class Solution {
    public int secondMinimum(int n, int[][] edges, int time, int change) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        int[][] dist = new int[n + 1][2];
        for (int i = 1; i <= n; i++) {
            dist[i][0] = dist[i][1] = Integer.MAX_VALUE;
        }
        dist[1][0] = 0;

        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{1, 0});

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int node = curr[0];
            int d = curr[1];

            for (int neighbor : adj.get(node)) {
                if (d + 1 < dist[neighbor][0]) {
                    dist[neighbor][1] = dist[neighbor][0];
                    dist[neighbor][0] = d + 1;
                    queue.offer(new int[]{neighbor, d + 1});
                } else if (d + 1 > dist[neighbor][0] && d + 1 < dist[neighbor][1]) {
                    dist[neighbor][1] = d + 1;
                    queue.offer(new int[]{neighbor, d + 1});
                }
            }
        }

        int ans = 0;
        for (int i = 0; i < dist[n][1]; i++) {
            if ((ans / change) % 2 == 1) {
                ans = (ans / change + 1) * change;
            }
            ans += time;
        }
        return ans;
    }
}