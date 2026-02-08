import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.PriorityQueue;

class Solution {
    public long[] shortestDistanceAfterRoadAdditionQueries(int n, int[][] queries) {
        List<List<int[]>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        long[] results = new long[queries.length];

        for (int qIdx = 0; qIdx < queries.length; qIdx++) {
            int u = queries[qIdx][0];
            int v = queries[qIdx][1];
            int w = queries[qIdx][2];

            adj.get(u).add(new int[]{v, w});
            adj.get(v).add(new int[]{u, w});

            long[] dist = new long[n];
            Arrays.fill(dist, Long.MAX_VALUE);
            dist[0] = 0;

            PriorityQueue<long[]> pq = new PriorityQueue<>(Comparator.comparingLong(a -> a[0]));
            pq.offer(new long[]{0, 0});

            while (!pq.isEmpty()) {
                long currentDist = pq.peek()[0];
                int currentNode = (int) pq.peek()[1];
                pq.poll();

                if (currentDist > dist[currentNode]) {
                    continue;
                }

                for (int[] edge : adj.get(currentNode)) {
                    int neighbor = edge[0];
                    int weight = edge[1];

                    if (dist[currentNode] != Long.MAX_VALUE && dist[currentNode] + weight < dist[neighbor]) {
                        dist[neighbor] = dist[currentNode] + weight;
                        pq.offer(new long[]{dist[neighbor], neighbor});
                    }
                }
            }

            long currentTotalDistance = 0;
            boolean allReachable = true;
            for (int i = 0; i < n; i++) {
                if (dist[i] == Long.MAX_VALUE) {
                    allReachable = false;
                    break;
                }
                currentTotalDistance += dist[i];
            }

            if (!allReachable) {
                results[qIdx] = -1;
            } else {
                results[qIdx] = currentTotalDistance;
            }
        }

        return results;
    }
}