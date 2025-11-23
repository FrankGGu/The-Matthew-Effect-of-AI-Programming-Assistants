public class Solution {

import java.util.*;

public class Solution {
    public int findMaxValueOfEquation(int[] nums, int k) {
        int n = nums.length;
        int maxVal = Integer.MIN_VALUE;
        Deque<int[]> dq = new LinkedList<>();

        for (int i = 0; i < n; i++) {
            while (!dq.isEmpty() && dq.peek()[0] < i - k) {
                dq.poll();
            }

            if (!dq.isEmpty()) {
                int[] top = dq.peek();
                maxVal = Math.max(maxVal, top[1] + nums[i] - top[0]);
            }

            while (!dq.isEmpty() && dq.getLast()[1] <= nums[i] - i) {
                dq.pollLast();
            }

            dq.addLast(new int[]{i, nums[i] - i});
        }

        return maxVal;
    }
}
}