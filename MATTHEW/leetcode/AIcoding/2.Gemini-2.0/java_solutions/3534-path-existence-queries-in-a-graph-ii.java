import java.util.*;

class Solution {
    public long[] distanceQueries(int n, int[][] edges, int[][] queries) {
        List<List<int[]>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(new int[]{edge[1], edge[2]});
            adj.get(edge[1]).add(new int[]{edge[0], edge[2]});
        }

        int m = queries.length;
        long[] result = new long[m];
        Arrays.fill(result, -1);

        for (int i = 0; i < m; i++) {
            int start = queries[i][0];
            int end = queries[i][1];

            PriorityQueue<long[]> pq = new PriorityQueue<>(Comparator.comparingLong(a -> a[1]));
            pq.offer(new long[]{start, 0});
            long[] dist = new long[n];
            Arrays.fill(dist, Long.MAX_VALUE);
            dist[start] = 0;

            while (!pq.isEmpty()) {
                long[] curr = pq.poll();
                int u = (int) curr[0];
                long d = curr[1];

                if (d > dist[u]) continue;

                if (u == end) {
                    result[i] = d;
                    break;
                }

                for (int[] neighbor : adj.get(u)) {
                    int v = neighbor[0];
                    int weight = neighbor[1];

                    if (dist[v] > dist[u] + weight) {
                        dist[v] = dist[u] + weight;
                        pq.offer(new long[]{v, dist[v]});
                    }
                }
            }
        }

        return result;
    }
}