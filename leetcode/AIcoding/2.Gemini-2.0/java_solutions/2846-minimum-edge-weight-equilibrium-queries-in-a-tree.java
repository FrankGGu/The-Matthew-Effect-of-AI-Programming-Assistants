import java.util.*;

class Solution {
    public int[] minEdgeWeight(int n, int[][] edges, int[][] queries) {
        List<int[]>[] adj = new List[n];
        for (int i = 0; i < n; i++) {
            adj[i] = new ArrayList<>();
        }
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            adj[u].add(new int[]{v, w});
            adj[v].add(new int[]{u, w});
        }

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int u = queries[i][0];
            int v = queries[i][1];
            int maxWeight = queries[i][2];

            int minCount = Integer.MAX_VALUE;
            Queue<int[]> queue = new LinkedList<>();
            queue.offer(new int[]{u, 0, 0, 0}); // node, pathCount, maxWeightCount, currentMax
            Set<Long> visited = new HashSet<>();
            visited.add((long) u);

            while (!queue.isEmpty()) {
                int[] curr = queue.poll();
                int node = curr[0];
                int pathCount = curr[1];
                int maxWeightCount = curr[2];
                int currentMax = curr[3];

                if (node == v) {
                    minCount = Math.min(minCount, maxWeightCount);
                    continue;
                }

                for (int[] neighborInfo : adj[node]) {
                    int neighbor = neighborInfo[0];
                    int weight = neighborInfo[1];
                    long key = ((long)node << 32) | neighbor;
                    long key2 = ((long)neighbor << 32) | node;

                    if (!visited.contains(key) && !visited.contains(key2)) {
                        visited.add(key);
                        visited.add(key2);
                        if (weight <= maxWeight) {
                            queue.offer(new int[]{neighbor, pathCount + 1, maxWeightCount + 1, Math.max(currentMax, weight)});
                        } else {
                            queue.offer(new int[]{neighbor, pathCount + 1, maxWeightCount, currentMax});
                        }

                    }
                }
            }

            if (minCount == Integer.MAX_VALUE) {
                result[i] = -1;
            } else {
                result[i] = minCount;
            }
        }

        return result;
    }
}