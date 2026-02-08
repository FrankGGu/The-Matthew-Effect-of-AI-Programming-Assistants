var maximumSum = function(arr) {
    const n = arr.length;

    // dp0[i]: maximum subarray sum ending at index i with 0 deletions.
    // dp1[i]: maximum subarray sum ending at index i with 1 deletion.

    // Initialize variables for the first element (index 0).
    // max_overall_sum stores the maximum sum found so far across all subarrays.
    let max_overall_sum = arr[0];

    // prev_dp0 corresponds to dp0[i-1]
    // prev_dp1 corresponds to dp1[i-1]
    // prev_prev_dp0 corresponds to dp0[i-2]

    // For i=0:
    // dp0[0] is arr[0].
    // dp1[0] is not possible (cannot delete from a single element), so -Infinity.
    let prev_dp0 = arr[0]; 
    let prev_dp1 = -Infinity; 

    // For i=1, when calculating dp1[1], we need dp0[i-2] which is dp0[-1].
    // A conceptual dp0[-1] (sum of an empty prefix) is 0.
    let prev_prev_dp0 = 0; 

    for (let i = 1; i < n; i++) {
        const current_val = arr[i];

        // Calculate current_dp0 (dp0[i]):
        // Either start a new subarray at current_val, or extend the previous one (prev_dp0 + current_val).
        let current_dp0 = Math.max(current_val, prev_dp0 + current_val);

        // Calculate current_dp1 (dp1[i]):
        // This represents a subarray ending at 'i' with one deletion.
        // There are two ways to achieve this:
        // 1. Extend a subarray that already had one deletion (dp1[i-1] + arr[i]).
        //    This is `prev_dp1 + current_val`.
        // 2. Delete arr[i-1] (the element just before arr[i]), and append arr[i]
        //    to the maximum subarray sum ending at i-2 with no deletions (dp0[i-2] + arr[i]).
        //    This is `prev_prev_dp0 + current_val`.
        let current_dp1 = Math.max(prev_dp1 + current_val, prev_prev_dp0 + current_val);

        // Update the overall maximum sum found so far.
        // The maximum can come from a subarray with 0 deletions (current_dp0)
        // or a subarray with 1 deletion (current_dp1).
        max_overall_sum = Math.max(max_overall_sum, current_dp0, current_dp1);

        // Shift values for the next iteration:
        // The current dp0 becomes prev_dp0 for the next iteration (dp0[i-1]).
        // The previous dp0 becomes prev_prev_dp0 for the next iteration (dp0[i-2]).
        prev_prev_dp0 = prev_dp0;
        prev_dp0 = current_dp0;
        prev_dp1 = current_dp1;
    }

    return max_overall_sum;
};