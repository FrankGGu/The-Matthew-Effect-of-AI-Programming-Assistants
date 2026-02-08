class Solution {
    public int maximumSum(int[] arr) {
        int n = arr.length;
        if (n == 0) {
            return 0;
        }

        // dp0: maximum sum of a subarray ending at the current index without any deletion.
        // dp1: maximum sum of a subarray ending at the current index with exactly one deletion.

        // Initialize for the first element.
        // A subarray ending at index 0 without deletion is just arr[0].
        int dp0 = arr[0];
        // A subarray ending at index 0 with one deletion is not possible if it must be non-empty.
        // So, we initialize it to a very small value to indicate an invalid state.
        int dp1 = Integer.MIN_VALUE; 

        // The overall maximum sum found so far. Initialize with arr[0] as a single element
        // is a valid non-empty subarray.
        int maxSum = arr[0]; 

        for (int i = 1; i < n; i++) {
            // Store previous dp values before updating for the current index.
            int prev_dp0 = dp0;
            int prev_dp1 = dp1;

            // Calculate current dp0:
            // Either start a new subarray with arr[i], or extend the previous subarray (prev_dp0 + arr[i]).
            dp0 = Math.max(arr[i], prev_dp0 + arr[i]);

            // Calculate current dp1:
            // There are two ways to form a subarray ending at 'i' with one deletion:
            // 1. Delete arr[i]: The sum is the maximum sum of a subarray ending at 'i-1' without deletion (prev_dp0).
            // 2. Extend a subarray that already had one deletion (prev_dp1) by adding arr[i].
            //    We only consider this option if prev_dp1 was a valid sum (not Integer.MIN_VALUE).
            if (prev_dp1 == Integer.MIN_VALUE) {
                // If no valid subarray with deletion ended at i-1, the only option is to delete arr[i].
                dp1 = prev_dp0;
            } else {
                dp1 = Math.max(prev_dp0, prev_dp1 + arr[i]);
            }

            // Update the overall maximum sum.
            // Consider the current dp0 (no deletion).
            maxSum = Math.max(maxSum, dp0);
            // Consider the current dp1 (one deletion), only if it represents a valid sum.
            if (dp1 != Integer.MIN_VALUE) {
                maxSum = Math.max(maxSum, dp1);
            }
        }

        return maxSum;
    }
}