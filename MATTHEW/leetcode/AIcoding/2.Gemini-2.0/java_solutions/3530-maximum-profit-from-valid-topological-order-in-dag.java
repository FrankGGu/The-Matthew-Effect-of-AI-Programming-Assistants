import java.util.*;

class Solution {
    public int maximumProfit(int n, int[][] edges, int[] amount) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        int[] indegree = new int[n];
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            indegree[edge[1]]++;
        }

        Queue<Integer> q = new LinkedList<>();
        for (int i = 0; i < n; i++) {
            if (indegree[i] == 0) {
                q.offer(i);
            }
        }

        long[] dp = new long[n];
        for (int i = 0; i < n; i++) {
            dp[i] = amount[i];
        }

        while (!q.isEmpty()) {
            int u = q.poll();
            for (int v : adj.get(u)) {
                dp[v] = Math.max(dp[v], dp[u] + amount[v]);
                indegree[v]--;
                if (indegree[v] == 0) {
                    q.offer(v);
                }
            }
        }

        long maxProfit = Long.MIN_VALUE;
        for (int i = 0; i < n; i++) {
            maxProfit = Math.max(maxProfit, dp[i]);
        }

        return (int) maxProfit;
    }
}