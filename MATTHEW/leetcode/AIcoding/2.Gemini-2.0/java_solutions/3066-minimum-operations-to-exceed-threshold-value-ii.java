import java.util.PriorityQueue;

class Solution {
    public int minOperations(int[] nums, int k) {
        PriorityQueue<Long> pq = new PriorityQueue<>();
        for (int num : nums) {
            pq.offer((long) num);
        }

        int operations = 0;
        while (pq.size() > 1 && pq.peek() < k) {
            long a = pq.poll();
            long b = pq.poll();
            pq.offer(Math.min(a * 2, b * 2));
            operations++;
        }

        return operations;
    }
}