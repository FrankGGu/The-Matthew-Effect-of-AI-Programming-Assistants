import java.util.ArrayDeque;
import java.util.Deque;

class Solution {
    public int constrainedSubsetSum(int[] nums, int k) {
        int n = nums.length;
        int[] dp = new int[n];
        Deque<Integer> dq = new ArrayDeque<>(); // Stores indices

        int maxSum = Integer.MIN_VALUE; // Overall maximum subsequence sum

        for (int i = 0; i < n; i++) {
            // Remove indices from the front of the deque that are out of the window [i-k, i-1]
            while (!dq.isEmpty() && dq.peekFirst() < i - k) {
                dq.removeFirst();
            }

            // Calculate dp[i]
            // dp[i] is nums[i] plus the maximum of 0 and the dp value of the best previous element
            // within the window [i-k, i-1].
            // Math.max(0, ...) ensures that we only extend a subsequence if it increases the sum,
            // otherwise, we start a new subsequence with nums[i].
            int prevMaxDp = 0;
            if (!dq.isEmpty()) {
                prevMaxDp = dp[dq.peekFirst()];
            }

            dp[i] = nums[i] + Math.max(0, prevMaxDp);

            // Update the overall maximum sum found so far
            maxSum = Math.max(maxSum, dp[i]);

            // Maintain the deque in decreasing order of dp values
            // Remove indices from the back of the deque whose dp values are less than or equal to dp[i].
            // This is because dp[i] is a better candidate for future windows (it's closer and provides
            // an equal or better sum).
            while (!dq.isEmpty() && dp[dq.peekLast()] <= dp[i]) {
                dq.removeLast();
            }
            // Add current index to the back of the deque
            dq.addLast(i);
        }

        return maxSum;
    }
}