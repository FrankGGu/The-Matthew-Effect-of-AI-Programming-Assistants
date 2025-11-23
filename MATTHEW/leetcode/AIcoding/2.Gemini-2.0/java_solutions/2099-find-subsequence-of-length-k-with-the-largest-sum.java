import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int[] maxSubsequence(int[] nums, int k) {
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        for (int i = 0; i < nums.length; i++) {
            pq.offer(new int[]{nums[i], i});
            if (pq.size() > k) {
                pq.poll();
            }
        }

        int[] indices = new int[k];
        int idx = 0;
        while (!pq.isEmpty()) {
            indices[idx++] = pq.poll()[1];
        }
        Arrays.sort(indices);

        int[] result = new int[k];
        for (int i = 0; i < k; i++) {
            result[i] = nums[indices[i]];
        }
        return result;
    }
}