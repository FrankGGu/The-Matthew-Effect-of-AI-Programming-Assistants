import java.util.*;

class Solution {
    public int countPaths(int n, int[][] roads) {
        final long MOD = 1_000_000_007;

        List<List<int[]>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] road : roads) {
            int u = road[0];
            int v = road[1];
            int time = road[2];
            adj.get(u).add(new int[]{v, time});
            adj.get(v).add(new int[]{u, time});
        }

        long[] dist = new long[n];
        Arrays.fill(dist, Long.MAX_VALUE);
        long[] ways = new long[n];
        Arrays.fill(ways, 0);

        dist[0] = 0;
        ways[0] = 1;

        // PriorityQueue stores {current_time, node_id}
        PriorityQueue<long[]> pq = new PriorityQueue<>((a, b) -> Long.compare(a[0], b[0]));
        pq.offer(new long[]{0, 0}); // Start node 0 with time 0

        while (!pq.isEmpty()) {
            long currTime = pq.peek()[0];
            int u = (int) pq.poll()[1];

            // If we found a shorter path to u already, skip this one
            if (currTime > dist[u]) {
                continue;
            }

            for (int[] neighbor : adj.get(u)) {
                int v = neighbor[0];
                int travelTime = neighbor[1];

                long newTime = currTime + travelTime;

                if (newTime < dist[v]) {
                    dist[v] = newTime;
                    ways[v] = ways[u];
                    pq.offer(new long[]{newTime, v});
                } else if (newTime == dist[v]) {
                    ways[v] = (ways[v] + ways[u]) % MOD;
                }
            }
        }

        return (int) ways[n - 1];
    }
}