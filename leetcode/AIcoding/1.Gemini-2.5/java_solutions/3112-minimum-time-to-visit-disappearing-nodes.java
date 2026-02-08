import java.util.*;

class Solution {
    public int[] minimumTime(int n, int[][] edges, int[] disappearingTime) {
        List<int[]>[] adj = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            adj[i] = new ArrayList<>();
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int length = edge[2];
            adj[u].add(new int[]{v, length});
            adj[v].add(new int[]{u, length});
        }

        int[] dist = new int[n];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[0] = 0;

        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[0]));
        pq.offer(new int[]{0, 0});

        while (!pq.isEmpty()) {
            int[] current = pq.poll();
            int currentTime = current[0];
            int u = current[1];

            if (currentTime > dist[u]) {
                continue;
            }

            if (currentTime >= disappearingTime[u]) {
                continue;
            }

            for (int[] neighbor : adj[u]) {
                int v = neighbor[0];
                int length = neighbor[1];
                int newTime = currentTime + length;

                if (newTime < disappearingTime[v]) {
                    if (newTime < dist[v]) {
                        dist[v] = newTime;
                        pq.offer(new int[]{newTime, v});
                    }
                }
            }
        }

        for (int i = 0; i < n; i++) {
            if (dist[i] == Integer.MAX_VALUE) {
                dist[i] = -1;
            }
        }

        return dist;
    }
}