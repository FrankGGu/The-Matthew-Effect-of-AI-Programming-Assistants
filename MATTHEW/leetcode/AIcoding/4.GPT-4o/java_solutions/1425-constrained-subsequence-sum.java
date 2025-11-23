import java.util.*;

class Solution {
    public int constrainedSubsetSum(int[] nums, int k) {
        int n = nums.length;
        Deque<Integer> deque = new LinkedList<>();
        int[] dp = new int[n];
        int maxSum = Integer.MIN_VALUE;

        for (int i = 0; i < n; i++) {
            dp[i] = nums[i];
            if (!deque.isEmpty()) {
                dp[i] = Math.max(dp[i], nums[i] + dp[deque.peekFirst()]);
            }
            while (!deque.isEmpty() && dp[deque.peekLast()] <= dp[i]) {
                deque.pollLast();
            }
            deque.offerLast(i);
            if (deque.peekFirst() == i - k) {
                deque.pollFirst();
            }
            maxSum = Math.max(maxSum, dp[i]);
        }

        return maxSum;
    }
}