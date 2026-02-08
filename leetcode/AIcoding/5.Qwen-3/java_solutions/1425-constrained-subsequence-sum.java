public class Solution {

import java.util.*;

public class Solution {
    public int constrainedSubsetSum(int[] nums, int k) {
        int n = nums.length;
        int[] dp = new int[n];
        Deque<Integer> dq = new LinkedList<>();

        for (int i = 0; i < n; i++) {
            int prev = dq.isEmpty() ? 0 : dp[dq.peekFirst()];
            dp[i] = prev + nums[i];

            while (!dq.isEmpty() && dp[i] >= dp[dq.peekLast()]) {
                dq.pollLast();
            }

            dq.addLast(i);

            if (dq.peekFirst() <= i - k) {
                dq.pollFirst();
            }
        }

        return Arrays.stream(dp).max().getAsInt();
    }
}
}