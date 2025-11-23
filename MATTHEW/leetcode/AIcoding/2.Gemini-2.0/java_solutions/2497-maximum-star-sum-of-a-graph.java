import java.util.*;

class Solution {
    public int maxStarSum(int[] vals, int[][] edges, int k) {
        int n = vals.length;
        List<PriorityQueue<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new PriorityQueue<>());
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            if (vals[v] > 0) {
                adj.get(u).offer(vals[v]);
                if (adj.get(u).size() > k) {
                    adj.get(u).poll();
                }
            }
            if (vals[u] > 0) {
                adj.get(v).offer(vals[u]);
                if (adj.get(v).size() > k) {
                    adj.get(v).poll();
                }
            }
        }

        int maxSum = Integer.MIN_VALUE;
        for (int i = 0; i < n; i++) {
            int currentSum = vals[i];
            PriorityQueue<Integer> pq = adj.get(i);
            for (int val : pq) {
                currentSum += val;
            }
            maxSum = Math.max(maxSum, currentSum);
        }

        return maxSum;
    }
}