import java.util.PriorityQueue;

class Solution {
    public long[] maxAndMinSubarrays(int[] nums, int k) {
        int n = nums.length;
        long[] result = new long[2];

        PriorityQueue<Integer> maxHeap = new PriorityQueue<>();
        PriorityQueue<Integer> minHeap = new PriorityQueue<>((a, b) -> b - a);

        long maxSum = 0;
        long minSum = 0;

        for (int i = 0; i < n; i++) {
            maxHeap.offer(nums[i]);
            minHeap.offer(nums[i]);

            if (maxHeap.size() > k) {
                maxHeap.poll();
            }
            if (minHeap.size() > k) {
                minHeap.poll();
            }
        }

        while (!maxHeap.isEmpty()) {
            maxSum += maxHeap.poll();
        }
        while (!minHeap.isEmpty()) {
            minSum += minHeap.poll();
        }

        result[0] = maxSum;
        result[1] = minSum;

        return result;
    }
}