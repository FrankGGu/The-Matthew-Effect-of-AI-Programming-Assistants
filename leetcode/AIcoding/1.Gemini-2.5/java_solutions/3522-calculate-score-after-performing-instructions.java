import java.util.Deque;
import java.util.LinkedList;

class Solution {
    public int maxResult(int[] nums, int k) {
        int n = nums.length;
        int[] dp = new int[n];

        // Deque stores indices. The front of the deque will always have the index
        // with the maximum dp value within the current sliding window [i-k, i-1].
        // Elements are stored in decreasing order of their dp values.
        Deque<Integer> deque = new LinkedList<>();

        // Base case: score at the starting index 0 is nums[0]
        dp[0] = nums[0];
        deque.addLast(0); // Add index 0 to the deque

        // Iterate from the second element to the last
        for (int i = 1; i < n; i++) {
            // Remove indices from the front of the deque that are no longer
            // within the k-step reach from the current index i.
            // i.e., if deque.peekFirst() < i - k, it's out of range.
            while (deque.peekFirst() < i - k) {
                deque.removeFirst();
            }

            // The maximum score to reach index i is nums[i] plus the maximum
            // score from an index j within the k-range (which is dp[deque.peekFirst()]).
            dp[i] = nums[i] + dp[deque.peekFirst()];

            // Remove indices from the back of the deque if their dp value is
            // less than or equal to dp[i]. This ensures the deque maintains
            // a strictly decreasing order of dp values from front to back.
            // If dp[i] is greater or equal, it's a better candidate for future jumps.
            while (!deque.isEmpty() && dp[deque.peekLast()] <= dp[i]) {
                deque.removeLast();
            }

            // Add the current index i to the back of the deque.
            deque.addLast(i);
        }

        // The maximum score to reach the last index (n-1) is the result.
        return dp[n - 1];
    }
}