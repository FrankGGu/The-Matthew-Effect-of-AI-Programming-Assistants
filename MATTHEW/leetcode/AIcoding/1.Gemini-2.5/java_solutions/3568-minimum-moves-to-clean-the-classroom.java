import java.util.Arrays;
import java.util.Deque;
import java.util.LinkedList;

class Solution {
    public int minimumMoves(String s, int k) {
        int n = s.length();

        // dp[i][j] = minimum cost to clean s[0...i-1] using j operations.
        // i goes from 0 to n, j goes from 0 to k.
        int[][] dp = new int[n + 1][k + 1];

        // Initialize dp table with a large value (infinity)
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
        }

        // Base case: 0 cost to clean an empty prefix with 0 operations.
        dp[0][0] = 0;

        // Precompute lastZeroIdx: lastZeroIdx[i] stores the index of the last '0' in s[0...i-1].
        // If no '0' exists, it's -1.
        int[] lastZeroIdx = new int[n + 1];
        lastZeroIdx[0] = -1;
        for (int i = 1; i <= n; i++) {
            if (s.charAt(i - 1) == '0') {
                lastZeroIdx[i] = i - 1;
            } else {
                lastZeroIdx[i] = lastZeroIdx[i - 1];
            }
        }

        // Iterate through number of operations
        for (int j = 1; j <= k; j++) {
            // Deque to maintain minimum of (dp[p][j-1] - p) for valid p in a sliding window.
            // Stores indices 'p'.
            Deque<Integer> dq = new LinkedList<>();

            // Iterate through the string prefix length
            for (int i = 1; i <= n; i++) {
                // Case 1: s[i-1] is '0'
                // If the current character is '0', it's already clean.
                // The cost to clean s[0...i-1] is the same as cleaning s[0...i-2] with the same number of operations.
                if (s.charAt(i - 1) == '0') {
                    if (dp[i - 1][j] != Integer.MAX_VALUE) {
                        dp[i][j] = Math.min(dp[i][j], dp[i - 1][j]);
                    }
                    // When a '0' is encountered, any segment of '1's must end before this '0'.
                    // So, the window for 'p' (start of the segment) is reset.
                    dq.clear();
                }

                // Consider adding `i-1` as a potential `p` (start of a segment) for future calculations.
                // `p` refers to the index *before* the segment starts.
                // The value to store/compare in the deque is `dp[p][j-1] - p`.
                // Here, `p` is `i-1`.
                if (dp[i - 1][j - 1] != Integer.MAX_VALUE) {
                    // Maintain monotonic increasing order of (dp[p_val][j-1] - p_val) in deque.
                    // Remove elements from tail that are greater than or equal to current value.
                    int currentValForDeque = dp[i - 1][j - 1] - (i - 1);
                    while (!dq.isEmpty() && (dp[dq.peekLast()][j - 1] - dq.peekLast()) >= currentValForDeque) {
                        dq.removeLast();
                    }
                    dq.addLast(i - 1); // Add index `i-1` to deque.
                }

                // Remove elements from head of deque that are outside the current valid window for `p`.
                // A segment `[p_actual, i-1]` of all '1's implies `p_actual > lastZeroIdx[i]`.
                // The deque stores `p_actual` values.
                while (!dq.isEmpty() && dq.peekFirst() <= lastZeroIdx[i]) {
                    dq.removeFirst();
                }

                // If deque is not empty, we can potentially form a segment ending at `i-1`.
                // This means `s[i-1]` must be '1' for this path to be valid (as `dq` would be cleared otherwise).
                // `p_optimal` is the index before the segment `[p_optimal, i-1]` starts.
                if (!dq.isEmpty()) {
                    int p_optimal = dq.peekFirst(); 
                    if (dp[p_optimal][j - 1] != Integer.MAX_VALUE) {
                        dp[i][j] = Math.min(dp[i][j], dp[p_optimal][j - 1] + (i - p_optimal));
                    }
                }
            }
        }

        // The final answer is the minimum cost to clean the entire string `s` using at most `k` operations.
        // We need to consider 0 operations up to k operations.
        int minTotalCost = Integer.MAX_VALUE;
        for (int j = 0; j <= k; j++) {
            minTotalCost = Math.min(minTotalCost, dp[n][j]);
        }

        return (minTotalCost == Integer.MAX_VALUE) ? -1 : minTotalCost;
    }
}