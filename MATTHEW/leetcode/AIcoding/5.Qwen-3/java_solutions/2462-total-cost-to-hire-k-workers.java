public class Solution {

import java.util.*;

public class Solution {
    public long totalCostToHireKWorkers(int[] costs, int k) {
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Collections.reverseOrder());

        for (int cost : costs) {
            minHeap.add(cost);
        }

        long totalCost = 0;

        for (int i = 0; i < k; i++) {
            int min = minHeap.peek();
            int max = maxHeap.peek();

            if (max == null || min <= max) {
                totalCost += minHeap.poll();
            } else {
                totalCost += maxHeap.poll();
            }
        }

        return totalCost;
    }
}
}