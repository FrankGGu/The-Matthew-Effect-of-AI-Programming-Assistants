import java.util.Arrays;

class Solution {
    public int maxSizeSlices(int[] slices) {
        int N = slices.length / 3;

        // Case 1: Exclude the last slice to break the circle.
        // We consider slices from index 0 to slices.length - 2.
        int[] slices1 = Arrays.copyOfRange(slices, 0, slices.length - 1);
        int result1 = solve(slices1, N);

        // Case 2: Exclude the first slice to break the circle.
        // We consider slices from index 1 to slices.length - 1.
        int[] slices2 = Arrays.copyOfRange(slices, 1, slices.length);
        int result2 = solve(slices2, N);

        return Math.max(result1, result2);
    }

    // Solves the linear version of the problem:
    // Find the maximum sum of k non-adjacent elements from array arr.
    private int solve(int[] arr, int k) {
        int M = arr.length;

        // dp_prev_prev represents the maximum sum when considering up to arr[i-2]
        // dp_prev represents the maximum sum when considering up to arr[i-1]
        // dp_curr represents the maximum sum when considering up to arr[i]
        // All arrays are of size k+1, where index j stores the max sum for choosing j slices.

        int[] dp_prev_prev = new int[k + 1]; // Corresponds to dp[i-2]
        int[] dp_prev = new int[k + 1];      // Corresponds to dp[i-1]

        // Initialize for the first element arr[0] (i=1 in 1-indexed DP state)
        if (k >= 1) {
            dp_prev[1] = arr[0];
        }

        // Iterate from the second element arr[1] up to arr[M-1]
        // In 1-indexed DP state, this corresponds to i from 2 to M.
        for (int i = 2; i <= M; i++) {
            int[] dp_curr = new int[k + 1];
            for (int j = 1; j <= k; j++) {
                // Option 1: Do not pick the current slice (arr[i-1]).
                // The max sum is the same as considering up to arr[i-2] with j slices.
                dp_curr[j] = dp_prev[j];

                // Option 2: Pick the current slice (arr[i-1]).
                // If we pick arr[i-1], we cannot pick arr[i-2].
                // So, we add arr[i-1] to the max sum of j-1 slices from arr[0...i-3].
                // This corresponds to dp_prev_prev[j-1].
                dp_curr[j] = Math.max(dp_curr[j], arr[i-1] + dp_prev_prev[j-1]);
            }
            // Shift the DP states for the next iteration
            dp_prev_prev = dp_prev;
            dp_prev = dp_curr;
        }

        // The result for considering all M elements and picking k slices is in dp_prev[k]
        return dp_prev[k];
    }
}