import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int findMinimumTime(int[][] corridors, int neededTime) {
        int n = 0;
        for (int[] corridor : corridors) {
            n = Math.max(n, Math.max(corridor[0], corridor[1]));
        }
        n++;

        PriorityQueue<int[]>[] adj = new PriorityQueue[n];
        for (int i = 0; i < n; i++) {
            adj[i] = new PriorityQueue<>((a, b) -> a[1] - b[1]);
        }

        for (int[] corridor : corridors) {
            adj[corridor[0] - 1].offer(new int[]{corridor[1] - 1, corridor[2]});
            adj[corridor[1] - 1].offer(new int[]{corridor[0] - 1, corridor[2]});
        }

        long[] dist = new long[n];
        Arrays.fill(dist, Long.MAX_VALUE);
        dist[0] = 0;

        PriorityQueue<long[]> pq = new PriorityQueue<>((a, b) -> Long.compare(a[0], b[0]));
        pq.offer(new long[]{0, 0});

        while (!pq.isEmpty()) {
            long[] curr = pq.poll();
            long d = curr[0];
            int u = (int) curr[1];

            if (d > dist[u]) {
                continue;
            }

            while (!adj[u].isEmpty()) {
                int[] edge = adj[u].poll();
                int v = edge[0];
                int w = edge[1];

                long arrival = dist[u];
                if (u != 0) {
                    long k = (arrival / neededTime);
                    if (arrival % neededTime != 0) {
                        k++;
                    }
                    arrival = k * neededTime;
                }

                if (dist[v] > arrival + w) {
                    dist[v] = arrival + w;
                    pq.offer(new long[]{dist[v], v});
                }
            }
        }

        if (dist[n - 1] == Long.MAX_VALUE) {
            return -1;
        }

        return (int) dist[n - 1];
    }
}