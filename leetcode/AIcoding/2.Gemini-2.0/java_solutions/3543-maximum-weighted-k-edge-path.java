import java.util.*;

class Solution {
    public int maxWeightedKEdgePath(int n, int[][] edges, int k) {
        List<List<int[]>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            adj.get(u).add(new int[]{v, w});
            adj.get(v).add(new int[]{u, w});
        }

        int maxWeight = -1;

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> b[1] - a[1]);
        pq.offer(new int[]{0, 0, 1 << 0});

        Set<String> visited = new HashSet<>();

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int u = curr[0], weight = curr[1], mask = curr[2];

            if (Integer.bitCount(mask) > k + 1) continue;

            if (u == n - 1 && Integer.bitCount(mask) == k + 1) {
                maxWeight = Math.max(maxWeight, weight);
                continue;
            }

            String key = u + "_" + mask;
            if (visited.contains(key)) continue;
            visited.add(key);

            for (int[] neighbor : adj.get(u)) {
                int v = neighbor[0], w = neighbor[1];
                if ((mask & (1 << v)) == 0) {
                    pq.offer(new int[]{v, weight + w, mask | (1 << v)});
                }
            }
        }

        return maxWeight;
    }
}