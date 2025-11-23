import java.util.PriorityQueue;

class Solution {
    public long totalCost(int[] costs, int k, int candidates) {
        int n = costs.length;
        long totalCost = 0;
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        int left = 0, right = n - 1;

        for (int i = 0; i < Math.min(candidates, n); i++) {
            minHeap.offer(costs[i]);
        }
        for (int i = Math.max(0, n - candidates); i < n; i++) {
            if (i >= candidates) {
                minHeap.offer(costs[i]);
            }
        }

        while (k > 0) {
            int minCost = minHeap.poll();
            totalCost += minCost;
            k--;

            if (left < n && (minHeap.isEmpty() || left < n - candidates)) {
                minHeap.offer(costs[left++]);
            } else if (right >= 0) {
                minHeap.offer(costs[right--]);
            }
        }

        return totalCost;
    }
}