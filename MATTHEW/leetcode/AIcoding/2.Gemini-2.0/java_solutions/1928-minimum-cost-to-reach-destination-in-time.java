import java.util.*;

class Solution {
    public int minCost(int maxTime, int[][] edges, int[] passingFees) {
        int n = passingFees.length;
        List<List<int[]>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int time = edge[2];
            adj.get(u).add(new int[]{v, time});
            adj.get(v).add(new int[]{u, time});
        }

        int[][] dp = new int[n][maxTime + 1];
        for (int i = 0; i < n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
        }

        dp[0][0] = passingFees[0];
        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[0]));
        pq.offer(new int[]{passingFees[0], 0, 0});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int cost = curr[0];
            int time = curr[1];
            int node = curr[2];

            if (cost > dp[node][time]) {
                continue;
            }

            if (node == n - 1) {
                return cost;
            }

            for (int[] neighbor : adj.get(node)) {
                int nextNode = neighbor[0];
                int nextTime = time + neighbor[1];

                if (nextTime <= maxTime) {
                    int nextCost = cost + passingFees[nextNode];
                    if (nextCost < dp[nextNode][nextTime]) {
                        dp[nextNode][nextTime] = nextCost;
                        pq.offer(new int[]{nextCost, nextTime, nextNode});
                    }
                }
            }
        }

        return -1;
    }
}