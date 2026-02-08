import java.util.PriorityQueue;

class Solution {
    public int minLengthAfterRemovals(int[] nums) {
        int n = nums.length;
        PriorityQueue<Integer> pq = new PriorityQueue<>((a, b) -> b - a);
        for (int num : nums) {
            pq.offer(num);
        }

        int removed = 0;
        int i = n / 2;
        while (i < n && !pq.isEmpty()) {
            int top = pq.poll();
            if (top > nums[i]) {
                removed++;
            } else {
                pq.offer(top);
            }
            i++;
        }

        return n - 2 * removed;
    }
}