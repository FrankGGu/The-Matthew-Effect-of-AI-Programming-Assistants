class Solution {
    public int minOperations(int[] nums, int k) {
        PriorityQueue<Long> minHeap = new PriorityQueue<>();
        for (int num : nums) {
            minHeap.offer((long) num);
        }

        int operations = 0;
        while (minHeap.size() >= 2 && minHeap.peek() < k) {
            long first = minHeap.poll();
            long second = minHeap.poll();
            long combined = Math.min(first, second) * 2 + Math.max(first, second);
            minHeap.offer(combined);
            operations++;
        }

        return operations;
    }
}