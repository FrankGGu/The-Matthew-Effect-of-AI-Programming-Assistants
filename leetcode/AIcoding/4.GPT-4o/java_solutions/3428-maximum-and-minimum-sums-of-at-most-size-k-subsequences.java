import java.util.Arrays;
import java.util.PriorityQueue;

public class Solution {
    public long[] maximumAndMinimumSums(int[] nums, int k) {
        long maxSum = 0, minSum = 0;
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>((a, b) -> b - a);
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();

        for (int num : nums) {
            maxHeap.offer(num);
            minHeap.offer(num);
        }

        for (int i = 0; i < k; i++) {
            maxSum += maxHeap.poll();
            minSum += minHeap.poll();
        }

        return new long[]{maxSum, minSum};
    }
}