public class Solution {

import java.util.*;

public class Solution {
    public int[] solve(int[] nums, int k) {
        int n = nums.length;
        int[] res = new int[n];
        Deque<Integer> dq = new ArrayDeque<>();

        for (int i = 0; i < n; i++) {
            while (!dq.isEmpty() && nums[dq.peekLast()] > nums[i]) {
                dq.pollLast();
            }
            dq.addLast(i);

            while (dq.peekFirst() <= i - k) {
                dq.pollFirst();
            }

            if (i >= k - 1) {
                res[i - k + 1] = nums[dq.peekFirst()];
            }
        }

        return res;
    }
}
}