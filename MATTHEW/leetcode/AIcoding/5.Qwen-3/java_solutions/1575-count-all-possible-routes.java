public class Solution {

import java.util.*;

public class Solution {
    public int countRoutes(int[][] roads, int s, int f) {
        int n = roads.length;
        Map<Integer, List<int[]>> graph = new HashMap<>();
        for (int[] road : roads) {
            int u = road[0], v = road[1], cost = road[2];
            graph.putIfAbsent(u, new ArrayList<>());
            graph.get(u).add(new int[]{v, cost});
            graph.putIfAbsent(v, new ArrayList<>());
            graph.get(v).add(new int[]{u, cost});
        }

        int[][] dp = new int[n][n];
        boolean[][] visited = new boolean[n][n];

        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[1]));
        pq.offer(new int[]{s, 0});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int node = curr[0], cost = curr[1];
            if (visited[node][cost]) continue;
            visited[node][cost] = true;

            for (int[] next : graph.getOrDefault(node, new ArrayList<>())) {
                int nextNode = next[0], nextCost = next[1];
                if (cost + nextCost <= n) {
                    dp[nextNode][cost + nextCost] += dp[node][cost];
                    pq.offer(new int[]{nextNode, cost + nextCost});
                }
            }

            if (node == f) {
                dp[node][cost]++;
            }
        }

        int result = 0;
        for (int i = 0; i <= n; i++) {
            result += dp[f][i];
        }

        return result;
    }
}
}