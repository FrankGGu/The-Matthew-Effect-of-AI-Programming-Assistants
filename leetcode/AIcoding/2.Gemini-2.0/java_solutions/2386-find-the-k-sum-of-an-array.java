import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public long kSum(int[] nums, int k) {
        long sum = 0;
        PriorityQueue<Long> pq = new PriorityQueue<>();
        pq.offer(0L);
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] > 0) {
                sum += nums[i];
            } else {
                nums[i] = -nums[i];
            }
        }
        Arrays.sort(nums);
        for (int num : nums) {
            PriorityQueue<Long> newPq = new PriorityQueue<>();
            while (!pq.isEmpty()) {
                long curr = pq.poll();
                newPq.offer(curr + num);
                newPq.offer(curr);
                if (newPq.size() > k) {
                    newPq.poll();
                }
            }
            pq = newPq;
        }
        long result = sum - pq.poll();
        return result;
    }
}