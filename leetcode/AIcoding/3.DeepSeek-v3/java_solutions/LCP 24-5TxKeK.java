class Solution {
    public int minOperations(int[] nums) {
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        for (int num : nums) {
            minHeap.offer(num);
        }
        int operations = 0;
        while (!minHeap.isEmpty()) {
            int current = minHeap.poll();
            if (current == 0) {
                continue;
            }
            if (current % 2 != 0) {
                operations++;
                current--;
            }
            if (current > 0) {
                current /= 2;
                minHeap.offer(current);
                operations++;
            }
        }
        return operations;
    }
}