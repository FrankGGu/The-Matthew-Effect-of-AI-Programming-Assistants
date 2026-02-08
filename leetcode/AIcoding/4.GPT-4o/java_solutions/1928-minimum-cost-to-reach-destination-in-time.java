import java.util.*;

class Solution {
    public int minCost(int maxTime, int[][] edges, int[] passingFees) {
        int n = passingFees.length;
        Map<Integer, List<int[]>> graph = new HashMap<>();
        for (int[] edge : edges) {
            graph.putIfAbsent(edge[0], new ArrayList<>());
            graph.putIfAbsent(edge[1], new ArrayList<>());
            graph.get(edge[0]).add(new int[]{edge[1], edge[2]});
            graph.get(edge[1]).add(new int[]{edge[0], edge[2]});
        }

        int[][] dp = new int[n][maxTime + 1];
        for (int[] row : dp) Arrays.fill(row, Integer.MAX_VALUE);
        dp[0][0] = passingFees[0];

        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[0]));
        pq.offer(new int[]{passingFees[0], 0, 0});

        while (!pq.isEmpty()) {
            int cost = pq.peek()[0];
            int node = pq.peek()[1];
            int time = pq.poll()[2];

            if (node == n - 1) return cost;

            if (cost > dp[node][time]) continue;

            for (int[] neighbor : graph.getOrDefault(node, new ArrayList<>())) {
                int nextNode = neighbor[0], travelTime = neighbor[1];
                int newTime = time + travelTime;
                if (newTime <= maxTime) {
                    int newCost = cost + passingFees[nextNode];
                    if (newCost < dp[nextNode][newTime]) {
                        dp[nextNode][newTime] = newCost;
                        pq.offer(new int[]{newCost, nextNode, newTime});
                    }
                }
            }
        }

        int minCost = Integer.MAX_VALUE;
        for (int i = 0; i <= maxTime; i++) {
            minCost = Math.min(minCost, dp[n - 1][i]);
        }

        return minCost == Integer.MAX_VALUE ? -1 : minCost;
    }
}