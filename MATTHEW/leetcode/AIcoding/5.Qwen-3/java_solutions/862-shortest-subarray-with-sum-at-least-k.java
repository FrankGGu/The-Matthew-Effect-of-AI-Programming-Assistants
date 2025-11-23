public class Solution {

import java.util.*;

public class Solution {
    public int shortestSubarray(int[] nums, int k) {
        int n = nums.length;
        long[] prefix = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        int res = Integer.MAX_VALUE;
        Deque<Integer> dq = new ArrayDeque<>();

        for (int i = 0; i <= n; i++) {
            while (!dq.isEmpty() && prefix[i] - prefix[dq.peekFirst()] >= k) {
                res = Math.min(res, i - dq.pollFirst());
            }

            while (!dq.isEmpty() && prefix[i] <= prefix[dq.peekLast()]) {
                dq.pollLast();
            }

            dq.addLast(i);
        }

        return res == Integer.MAX_VALUE ? -1 : res;
    }
}
}