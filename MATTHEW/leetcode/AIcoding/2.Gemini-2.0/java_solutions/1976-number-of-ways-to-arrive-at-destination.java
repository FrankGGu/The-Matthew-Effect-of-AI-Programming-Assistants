import java.util.*;

class Solution {
    public int countPaths(int n, int[][] roads) {
        List<List<Pair>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] road : roads) {
            int u = road[0];
            int v = road[1];
            int time = road[2];
            adj.get(u).add(new Pair(v, time));
            adj.get(v).add(new Pair(u, time));
        }

        long[] dist = new long[n];
        int[] ways = new int[n];
        Arrays.fill(dist, Long.MAX_VALUE);
        dist[0] = 0;
        ways[0] = 1;

        PriorityQueue<Pair> pq = new PriorityQueue<>(Comparator.comparingLong(p -> p.time));
        pq.offer(new Pair(0, 0));

        int MOD = 1000000007;

        while (!pq.isEmpty()) {
            Pair curr = pq.poll();
            int u = curr.node;
            long time = curr.time;

            if (time > dist[u]) {
                continue;
            }

            for (Pair neighbor : adj.get(u)) {
                int v = neighbor.node;
                long newTime = time + neighbor.time;

                if (newTime < dist[v]) {
                    dist[v] = newTime;
                    ways[v] = ways[u];
                    pq.offer(new Pair(v, newTime));
                } else if (newTime == dist[v]) {
                    ways[v] = (ways[v] + ways[u]) % MOD;
                }
            }
        }

        return ways[n - 1];
    }

    static class Pair {
        int node;
        long time;

        public Pair(int node, long time) {
            this.node = node;
            this.time = time;
        }
    }
}