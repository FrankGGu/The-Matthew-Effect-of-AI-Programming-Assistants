import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public long minSumSquareDiff(int[] nums1, int[] nums2, int k1, int k2) {
        PriorityQueue<Integer> pq = new PriorityQueue<>((a, b) -> b - a);
        for (int i = 0; i < nums1.length; i++) {
            pq.offer(Math.abs(nums1[i] - nums2[i]));
        }
        int totalK = k1 + k2;
        while (totalK > 0) {
            int top = pq.poll();
            if (top == 0) {
                break;
            }
            pq.offer(top - 1);
            totalK--;
        }
        long sum = 0;
        while (!pq.isEmpty()) {
            long val = pq.poll();
            sum += val * val;
        }
        return sum;
    }
}