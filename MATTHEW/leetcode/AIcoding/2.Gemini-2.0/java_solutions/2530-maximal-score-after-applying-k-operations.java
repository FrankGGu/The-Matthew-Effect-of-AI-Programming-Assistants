import java.util.PriorityQueue;

class Solution {
    public int maximumScore(int[] nums, int k) {
        PriorityQueue<Integer> pq = new PriorityQueue<>((a, b) -> b - a);
        for (int num : nums) {
            pq.offer(num);
        }

        long score = 0;
        for (int i = 0; i < k; i++) {
            int top = pq.poll();
            score += top;
            pq.offer((top + 2 - 1) / 2);
        }

        return (int) score;
    }
}