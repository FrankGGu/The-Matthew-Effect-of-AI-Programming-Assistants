import java.util.*;

class Solution {
    public long kSum(int[] nums, int k) {
        int n = nums.length;
        long total = 0;
        for (int i = 0; i < n; i++) {
            if (nums[i] > 0) {
                total += nums[i];
            } else {
                nums[i] = -nums[i];
            }
        }
        Arrays.sort(nums);

        PriorityQueue<long[]> pq = new PriorityQueue<>((a, b) -> Long.compare(b[0], a[0]));
        pq.offer(new long[]{total, 0});

        long result = 0;
        for (int i = 0; i < k; i++) {
            long[] curr = pq.poll();
            result = curr[0];
            int idx = (int)curr[1];
            if (idx < n) {
                pq.offer(new long[]{result - nums[idx], idx + 1});
                if (idx > 0) {
                    pq.offer(new long[]{result - nums[idx] + nums[idx - 1], idx + 1});
                }
            }
        }
        return result;
    }
}