import java.util.PriorityQueue;

class Solution {
    public long totalCost(int[] costs, int k, int candidates) {
        int n = costs.length;
        PriorityQueue<Integer> pq1 = new PriorityQueue<>();
        PriorityQueue<Integer> pq2 = new PriorityQueue<>();

        for (int i = 0; i < candidates && i < n; i++) {
            pq1.offer(costs[i]);
        }

        for (int i = Math.max(candidates, n - candidates); i < n; i++) {
            pq2.offer(costs[i]);
        }

        long totalCost = 0;
        int nextLeft = candidates;
        int nextRight = n - candidates - 1;

        for (int i = 0; i < k; i++) {
            if (pq2.isEmpty() || (!pq1.isEmpty() && pq1.peek() <= pq2.peek())) {
                totalCost += pq1.poll();
                if (nextLeft <= nextRight) {
                    pq1.offer(costs[nextLeft++]);
                }
            } else {
                totalCost += pq2.poll();
                if (nextLeft <= nextRight) {
                    pq2.offer(costs[nextRight--]);
                }
            }
        }

        return totalCost;
    }
}