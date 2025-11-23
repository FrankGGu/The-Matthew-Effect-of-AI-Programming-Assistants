import java.util.Deque;
import java.util.LinkedList;
import java.util.Arrays;

class Solution {
    public long minimumCost(int[] nums, int k, int dist) {
        int n = nums.length;

        // dp[i] will store the minimum sum of (j) chosen elements (excluding nums[0]),
        // where nums[i] is the j-th chosen element.
        // We need to pick k-1 additional elements.
        // Initialize prev_dp for j=0 (representing the state before picking the first additional element).
        // prev_dp[0] = 0 (cost for 0 elements chosen, effectively starting point).
        // All other prev_dp[i] = Long.MAX_VALUE (infinity).
        long[] prev_dp = new long[n];
        Arrays.fill(prev_dp, Long.MAX_VALUE);
        prev_dp[0] = 0L; // Represents the implicit start at index 0 with 0 cost for chosen elements so far.

        // Iterate j from 1 to k-1 (number of additional elements to choose)
        for (int j = 1; j < k; j++) {
            long[] current_dp = new long[n];
            Arrays.fill(current_dp, Long.MAX_VALUE);
            Deque<Integer> dq = new LinkedList<>(); // Stores indices p for prev_dp[p] values

            // Iterate i from 1 to n-1 (current index for the j-th element)
            // The j-th element's index `i` must be at least `j`.
            // The previous (j-1)-th element's index `p` must be at least `j-1`.
            // The window for `p` is `[max(j-1, i-dist), i-1]`.
            // The `prev_dp[p] != Long.MAX_VALUE` check implicitly handles `p >= j-1`
            // because `prev_dp[p]` would be `Long.MAX_VALUE` for `p < j-1`.
            for (int i = 1; i < n; i++) {
                // Add `i-1` to the deque if `prev_dp[i-1]` is a valid (not infinity) cost.
                // This `i-1` is a candidate for `p` (previous chosen index) for future `i'` values.
                if (prev_dp[i-1] != Long.MAX_VALUE) {
                    // Remove elements from the back of the deque that are worse than prev_dp[i-1].
                    while (!dq.isEmpty() && prev_dp[dq.peekLast()] >= prev_dp[i-1]) {
                        dq.removeLast();
                    }
                    dq.addLast(i-1);
                }

                // Remove elements from the front of the deque that are out of the valid window `[i-dist, i-1]`.
                // An index `p` is too old if `p < i - dist`.
                while (!dq.isEmpty() && dq.peekFirst() < i - dist) {
                    dq.removeFirst();
                }

                // If the deque is not empty, `prev_dp[dq.peekFirst()]` is the minimum cost for (j-1) elements
                // ending at a valid previous index `p`.
                // The current index `i` must be at least `j` (minimum index for `j` chosen elements).
                // If `i < j`, it's impossible to pick `j` elements ending at `i`.
                if (i >= j && !dq.isEmpty()) {
                    current_dp[i] = (long)nums[i] + prev_dp[dq.peekFirst()];
                }
            }
            prev_dp = current_dp;
        }

        // After k-1 iterations, prev_dp contains the minimum sum of k-1 chosen elements
        // where prev_dp[i] means the k-1-th element was nums[i].
        // Find the minimum among all possible ending indices for the k-1-th element.
        // The k-1-th element's index must be at least k-1.
        long min_sum_k_minus_1_elements = Long.MAX_VALUE;
        for (int i = k - 1; i < n; i++) {
            min_sum_k_minus_1_elements = Math.min(min_sum_k_minus_1_elements, prev_dp[i]);
        }

        // The total cost is nums[0] + the minimum sum of k-1 chosen elements.
        return (long)nums[0] + min_sum_k_minus_1_elements;
    }
}