import java.util.PriorityQueue;

class Solution {
    public int minOperations(int[] nums) {
        PriorityQueue<Integer> pq = new PriorityQueue<>();
        for (int num : nums) {
            pq.offer(num);
        }

        int operations = 0;
        while (!pq.isEmpty()) {
            int current = pq.poll();
            operations++;
            if (current - 1 > 0) {
                pq.offer(current - 1);
            }
        }
        return operations;
    }
}