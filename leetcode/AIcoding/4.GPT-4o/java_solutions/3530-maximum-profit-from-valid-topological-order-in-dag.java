import java.util.*;

class Solution {
    public int maximumProfit(int n, int[][] edges, int[] profits) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        int[] indegree = new int[n];
        for (int[] edge : edges) {
            graph.putIfAbsent(edge[0], new ArrayList<>());
            graph.get(edge[0]).add(edge[1]);
            indegree[edge[1]]++;
        }

        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < n; i++) {
            if (indegree[i] == 0) {
                queue.offer(i);
            }
        }

        int[] dp = new int[n];
        for (int i = 0; i < n; i++) {
            dp[i] = profits[i];
        }

        while (!queue.isEmpty()) {
            int node = queue.poll();
            for (int neighbor : graph.getOrDefault(node, new ArrayList<>())) {
                dp[neighbor] = Math.max(dp[neighbor], dp[node] + profits[neighbor]);
                indegree[neighbor]--;
                if (indegree[neighbor] == 0) {
                    queue.offer(neighbor);
                }
            }
        }

        int maxProfit = 0;
        for (int profit : dp) {
            maxProfit = Math.max(maxProfit, profit);
        }

        return maxProfit;
    }
}