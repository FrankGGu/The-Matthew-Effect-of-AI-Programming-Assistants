import java.util.ArrayDeque;
import java.util.Deque;

class Solution {
    public long minimumCoins(int[] prices) {
        int n = prices.length;
        // dp[i] will store the minimum cost to buy fruits from index i to n-1.
        // We need dp[n] as a base case (cost to buy from n to n-1 is 0).
        // The maximum index for dp lookup can be 2*i+2, which for i=0 is 2.
        // For i=n-1, it's min(n, 2*(n-1)+2) = min(n, 2n) = n.
        // So, dp array of size n+1 is sufficient.
        long[] dp = new long[n + 1];

        // Base case: No fruits to buy from index n onwards, so cost is 0.
        dp[n] = 0;

        // Deque to maintain indices j such that dp[j] values are in non-decreasing order.
        // This allows efficient retrieval of the minimum dp value in a sliding window.
        Deque<Integer> dq = new ArrayDeque<>();
        // Add the base case index n to the deque.
        dq.offerLast(n);

        // Iterate from n-1 down to 0
        for (int i = n - 1; i >= 0; i--) {
            // The current fruit is `i`. We must buy it, costing `prices[i]`.
            // After buying fruit `i`, we get to choose any fruit `j` from `i+1` to `2*i+1` for free.
            // This means the next fruit we *must* buy is `j+1`.
            // So, we need to find the minimum `dp[k]` where `k = j+1`.
            // The range for `j` is `[i, min(n-1, 2*i+1)]` (including `j=i` for not taking a free fruit).
            // Thus, the range for `k` is `[i+1, min(n, 2*i+2)]`.
            // Let `windowRightBoundary` be `min(n, 2*i+2)`.

            int windowRightBoundary = Math.min(n, 2 * i + 2);

            // Remove indices from the front of the deque that are outside the current window's right boundary.
            // These indices are no longer valid candidates for the minimum in the current window.
            while (!dq.isEmpty() && dq.peekFirst() > windowRightBoundary) {
                dq.pollFirst();
            }

            // The minimum `dp` value in the current window `[i+1, windowRightBoundary]`
            // is at the front of the deque.
            long minNextCost = dp[dq.peekFirst()];

            // Calculate dp[i]
            dp[i] = prices[i] + minNextCost;

            // Add the current index `i` to the deque, maintaining the monotonic property.
            // Remove elements from the back of the deque whose `dp` value is greater than or equal to `dp[i]`.
            // This ensures the deque remains sorted by `dp` values (non-decreasing).
            while (!dq.isEmpty() && dp[dq.peekLast()] >= dp[i]) {
                dq.pollLast();
            }
            dq.offerLast(i);
        }

        // The result is the minimum cost to buy all fruits starting from index 0.
        return dp[0];
    }
}