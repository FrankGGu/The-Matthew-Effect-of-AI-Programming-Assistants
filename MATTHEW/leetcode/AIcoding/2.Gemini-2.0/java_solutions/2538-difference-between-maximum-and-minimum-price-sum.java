import java.util.*;

class Solution {
    public long maxProfit(int n, int[] price, int[][] edges) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        long[] dp = new long[n];
        boolean[] visited = new boolean[n];
        dp[0] = price[0];
        visited[0] = true;

        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.<int[]>comparingLong(a -> - (long)a[1]));
        pq.offer(new int[]{0, price[0]});

        long maxProfit = 0;

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int u = curr[0];
            long currPriceSum = (long)curr[1];
            maxProfit = Math.max(maxProfit, currPriceSum);

            for (int v : adj.get(u)) {
                if (!visited[v]) {
                    visited[v] = true;
                    dp[v] = currPriceSum + price[v];
                    pq.offer(new int[]{v, (int)dp[v]});
                }
            }
        }

        Arrays.fill(visited, false);
        Arrays.fill(dp, 0);
        dp[0] = price[0];
        visited[0] = true;

        pq = new PriorityQueue<>(Comparator.<int[]>comparingLong(a -> - (long)a[1]));
        pq.offer(new int[]{0, price[0]});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int u = curr[0];
            long currPriceSum = (long)curr[1];
            maxProfit = Math.max(maxProfit, currPriceSum);

            for (int v : adj.get(u)) {
                if (!visited[v]) {
                    visited[v] = true;
                    dp[v] = currPriceSum + price[v];
                    pq.offer(new int[]{v, (int)dp[v]});
                }
            }
        }

        return maxProfit;
    }
}