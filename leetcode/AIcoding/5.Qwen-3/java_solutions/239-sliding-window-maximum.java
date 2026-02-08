public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> slidingWindowMaximum(int[] nums, int k) {
        Deque<Integer> dq = new ArrayDeque<>();
        List<Integer> result = new ArrayList<>();

        for (int i = 0; i < nums.length; i++) {
            while (!dq.isEmpty() && nums[i] >= nums[dq.peekLast()]) {
                dq.pollLast();
            }
            dq.addLast(i);

            if (dq.peekFirst() < i - k + 1) {
                dq.pollFirst();
            }

            if (i >= k - 1) {
                result.add(nums[dq.peekFirst()]);
            }
        }

        return result;
    }
}
}