import java.util.PriorityQueue;

class Solution {
    public long totalCost(int[] costs, int k, int candidates) {
        long totalCost = 0;
        PriorityQueue<Integer> pq1 = new PriorityQueue<>(); // Stores workers from the beginning
        PriorityQueue<Integer> pq2 = new PriorityQueue<>(); // Stores workers from the end

        int left = 0;
        int right = costs.length - 1;

        // Populate initial candidates for both queues
        for (int i = 0; i < candidates; i++) {
            if (left <= right) {
                pq1.offer(costs[left]);
                left++;
            }
        }
        for (int i = 0; i < candidates; i++) {
            if (left <= right) { // Check again, in case costs.length < 2 * candidates
                pq2.offer(costs[right]);
                right--;
            }
        }

        // Hire k workers
        for (int i = 0; i < k; i++) {
            if (pq1.isEmpty()) {
                totalCost += pq2.poll();
                if (left <= right) {
                    pq2.offer(costs[right]);
                    right--;
                }
            } else if (pq2.isEmpty()) {
                totalCost += pq1.poll();
                if (left <= right) {
                    pq1.offer(costs[left]);
                    left++;
                }
            } else { // Both are not empty
                if (pq1.peek() <= pq2.peek()) {
                    totalCost += pq1.poll();
                    if (left <= right) {
                        pq1.offer(costs[left]);
                        left++;
                    }
                } else {
                    totalCost += pq2.poll();
                    if (left <= right) {
                        pq2.offer(costs[right]);
                        right--;
                    }
                }
            }
        }

        return totalCost;
    }
}