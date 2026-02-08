class Solution {
    public int constrainedSubsetSum(int[] nums, int k) {
        int n = nums.length;
        int[] dp = new int[n];
        Deque<Integer> deque = new LinkedList<>();
        int maxSum = Integer.MIN_VALUE;

        for (int i = 0; i < n; i++) {
            if (!deque.isEmpty() && i - deque.peekFirst() > k) {
                deque.pollFirst();
            }
            dp[i] = nums[i] + (deque.isEmpty() ? 0 : dp[deque.peekFirst()]);
            dp[i] = Math.max(dp[i], nums[i]);

            while (!deque.isEmpty() && dp[i] >= dp[deque.peekLast()]) {
                deque.pollLast();
            }
            deque.offerLast(i);
            maxSum = Math.max(maxSum, dp[i]);
        }

        return maxSum;
    }
}