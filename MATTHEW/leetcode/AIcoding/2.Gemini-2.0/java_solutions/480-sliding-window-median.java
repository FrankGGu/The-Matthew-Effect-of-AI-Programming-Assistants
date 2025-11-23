import java.util.Comparator;
import java.util.PriorityQueue;

class Solution {
    public double[] medianSlidingWindow(int[] nums, int k) {
        double[] result = new double[nums.length - k + 1];
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Comparator.reverseOrder());

        for (int i = 0; i < nums.length; i++) {
            if (maxHeap.isEmpty() || nums[i] <= maxHeap.peek()) {
                maxHeap.offer(nums[i]);
            } else {
                minHeap.offer(nums[i]);
            }

            balanceHeaps(minHeap, maxHeap);

            if (i >= k - 1) {
                if (k % 2 == 0) {
                    result[i - k + 1] = ((double) maxHeap.peek() + minHeap.peek()) / 2;
                } else {
                    result[i - k + 1] = maxHeap.peek();
                }

                int numToRemove = nums[i - k + 1];
                if (numToRemove <= maxHeap.peek()) {
                    maxHeap.remove(numToRemove);
                } else {
                    minHeap.remove(numToRemove);
                }

                balanceHeaps(minHeap, maxHeap);
            }
        }

        return result;
    }

    private void balanceHeaps(PriorityQueue<Integer> minHeap, PriorityQueue<Integer> maxHeap) {
        while (maxHeap.size() - minHeap.size() > 1) {
            minHeap.offer(maxHeap.poll());
        }

        while (minHeap.size() > maxHeap.size()) {
            maxHeap.offer(minHeap.poll());
        }
    }
}