import java.util.Deque;
import java.util.LinkedList;

class Solution {
    public int maxResult(int[] nums, int k) {
        int n = nums.length;
        int[] dp = new int[n];
        Deque<Integer> dq = new LinkedList<>();

        dp[0] = nums[0];
        dq.offerLast(0);

        for (int i = 1; i < n; i++) {
            while (dq.peekFirst() < i - k) {
                dq.pollFirst();
            }
            dp[i] = nums[i] + dp[dq.peekFirst()];
            while (!dq.isEmpty() && dp[dq.peekLast()] <= dp[i]) {
                dq.pollLast();
            }
            dq.offerLast(i);
        }

        return dp[n - 1];
    }
}