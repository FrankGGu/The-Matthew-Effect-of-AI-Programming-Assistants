import java.util.*;

class Solution {
    public int minimumTime(int n, int[][] edges, List<Integer> nodeTime, int change) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        int[] dist = new int[n];
        Arrays.fill(dist, -1);
        dist[0] = 0;
        Queue<Integer> q = new LinkedList<>();
        q.offer(0);

        while (!q.isEmpty()) {
            int u = q.poll();
            for (int v : adj.get(u)) {
                if (dist[v] == -1) {
                    dist[v] = dist[u] + 1;
                    q.offer(v);
                }
            }
        }

        int time = 0;
        for (int i = 0; i < n; i++) {
            if (i != 0) {
                if ((time / change) % 2 != 0) {
                    time = (time / change + 1) * change;
                }
                time++;
            }
            time += nodeTime.get(i);
        }

        return time;
    }
}