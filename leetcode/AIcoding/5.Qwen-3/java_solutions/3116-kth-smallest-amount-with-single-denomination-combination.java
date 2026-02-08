public class Solution {

import java.util.PriorityQueue;

public class Solution {
    public long kthSmallestCombination(int[] denominations, int k) {
        PriorityQueue<Long> minHeap = new PriorityQueue<>();
        for (int d : denominations) {
            minHeap.offer((long) d);
        }

        for (int i = 1; i < k; i++) {
            long current = minHeap.poll();
            for (int d : denominations) {
                minHeap.offer(current + d);
            }
        }

        return minHeap.peek();
    }
}
}