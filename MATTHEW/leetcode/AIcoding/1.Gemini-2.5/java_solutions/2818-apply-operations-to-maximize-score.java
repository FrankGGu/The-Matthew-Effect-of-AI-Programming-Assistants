import java.util.PriorityQueue;
import java.util.Collections;

class Solution {
    public long maxScore(int[] nums, int k) {
        PriorityQueue<Integer> pq = new PriorityQueue<>(Collections.reverseOrder());
        for (int num : nums) {
            pq.offer(num);
        }

        long totalScore = 0;
        for (int i = 0; i < k; i++) {
            int currentMax = pq.poll();
            totalScore += currentMax;
            pq.offer(currentMax / 3);
        }

        return totalScore;
    }
}