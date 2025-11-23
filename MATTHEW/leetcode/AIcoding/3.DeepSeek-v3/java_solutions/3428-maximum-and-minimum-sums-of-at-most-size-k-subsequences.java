import java.util.*;

class Solution {
    public long[] maximumAndMinimum(int[] nums, int k) {
        long[] result = new long[2];
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Collections.reverseOrder());

        long minSum = 0;
        long maxSum = 0;

        for (int num : nums) {
            minHeap.offer(num);
            maxHeap.offer(num);
        }

        for (int i = 0; i < k; i++) {
            minSum += minHeap.poll();
            maxSum += maxHeap.poll();
        }

        result[0] = maxSum;
        result[1] = minSum;
        return result;
    }
}