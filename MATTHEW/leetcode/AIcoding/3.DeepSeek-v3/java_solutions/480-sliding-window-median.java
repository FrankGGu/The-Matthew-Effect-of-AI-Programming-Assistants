class Solution {
    public double[] medianSlidingWindow(int[] nums, int k) {
        if (nums == null || nums.length == 0 || k <= 0) {
            return new double[0];
        }
        double[] result = new double[nums.length - k + 1];
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Collections.reverseOrder());

        for (int i = 0; i < nums.length; i++) {
            if (maxHeap.isEmpty() || nums[i] <= maxHeap.peek()) {
                maxHeap.offer(nums[i]);
            } else {
                minHeap.offer(nums[i]);
            }

            balanceHeaps(minHeap, maxHeap);

            if (i >= k - 1) {
                result[i - k + 1] = getMedian(minHeap, maxHeap, k);
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
        while (maxHeap.size() > minHeap.size() + 1) {
            minHeap.offer(maxHeap.poll());
        }
        while (minHeap.size() > maxHeap.size()) {
            maxHeap.offer(minHeap.poll());
        }
    }

    private double getMedian(PriorityQueue<Integer> minHeap, PriorityQueue<Integer> maxHeap, int k) {
        if (k % 2 == 0) {
            return ((double) maxHeap.peek() + (double) minHeap.peek()) / 2.0;
        } else {
            return (double) maxHeap.peek();
        }
    }
}