public class Solution {

import java.util.Arrays;
import java.util.PriorityQueue;

public class Solution {
    public int minAbsoluteDifference(int[] nums, int x) {
        int n = nums.length;
        int result = Integer.MAX_VALUE;
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);

        for (int i = 0; i < n; i++) {
            if (i > 0) {
                pq.offer(new int[]{Math.abs(nums[i] - nums[i - 1]), i - 1, i});
            }
            if (i < n - 1) {
                pq.offer(new int[]{Math.abs(nums[i] - nums[i + 1]), i, i + 1});
            }
        }

        while (!pq.isEmpty()) {
            int[] current = pq.poll();
            int diff = current[0];
            int left = current[1];
            int right = current[2];

            if (diff >= result) {
                continue;
            }

            result = diff;

            if (left > 0) {
                pq.offer(new int[]{Math.abs(nums[left] - nums[left - 1]), left - 1, left});
            }
            if (right < n - 1) {
                pq.offer(new int[]{Math.abs(nums[right] - nums[right + 1]), right, right + 1});
            }
        }

        return result;
    }
}
}