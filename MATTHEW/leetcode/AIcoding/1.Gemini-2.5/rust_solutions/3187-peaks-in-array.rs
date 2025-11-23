use std::cmp::max;

impl Solution {
    pub fn max_peaks(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();

        if n < 3 {
            return 0;
        }

        // Maximum possible peaks in an array of size n.
        // Peaks must be at indices 1 to n-2, and must be separated by at least one element.
        // So, indices can be i, i+2, i+4, ...
        // The maximum number of such non-overlapping positions is (n - 1) / 2.
        let max_possible_peaks_count = (n - 1) / 2;

        // If 'k' operations are enough to make all possible peaks, then we can achieve
        // the maximum possible number of peaks. Each peak costs at most 1 operation.
        // So, if k is greater than or equal to the maximum possible peaks, we can achieve them all.
        if k as usize >= max_possible_peaks_count {
            return max_possible_peaks_count as i32;
        }

        // k_cap is the effective maximum number of operations we might need to consider in DP.
        // It's capped at `k` because we can't use more operations than available.
        // It's also implicitly capped by max_possible_peaks_count because even if k is larger,
        // we can't create more peaks. But this case is handled by the early return above.
        let k_cap = k as usize;

        // DP states:
        // dp_not_peak[j] stores the maximum peaks achieved using `j` operations,
        // where the current element (nums[i]) is NOT a peak.
        // dp_is_peak[j] stores the maximum peaks achieved using `j` operations,
        // where the current element (nums[i]) IS a peak.
        // We use three layers for space optimization: curr, prev, prev_prev.
        let mut dp_prev_prev_not_peak = vec![-1; k_cap + 1]; // Corresponds to i-2
        let mut dp_prev_not_peak = vec![-1; k_cap + 1];     // Corresponds to i-1
        let mut dp_curr_not_peak = vec![-1; k_cap + 1];     // Corresponds to i

        let mut dp_prev_prev_is_peak = vec![-1; k_cap + 1]; // Corresponds to i-2
        let mut dp_prev_is_peak = vec![-1; k_cap + 1];     // Corresponds to i-1
        let mut dp_curr_is_peak = vec![-1; k_cap + 1];     // Corresponds to i

        // Base case: Before index 0, 0 peaks, 0 cost.
        // This state represents that up to index 0 (exclusive), we have 0 peaks and used 0 operations.
        dp_prev_prev_not_peak[0] = 0;

        // Loop i from 1 to n-1 (inclusive)
        // i represents the current index being considered for its peak status.
        // dp_prev_prev_... holds values for index i-2
        // dp_prev_... holds values for index i-1
        // dp_curr_... holds values for index i
        for i in 1..n {
            // Initialize current dp states for this `i`
            for j in 0..=k_cap {
                dp_curr_not_peak[j] = -1;
                dp_curr_is_peak[j] = -1;
            }

            for j in 0..=k_cap {
                // Transition for dp_curr_not_peak[j] (nums[i] is NOT a peak)
                // If nums[i] is not a peak, it could be that nums[i-1] was a peak,
                // or nums[i-1] was not a peak. We take the maximum number of peaks
                // from either of these possibilities from the previous index (i-1).
                let from_prev_not_peak = dp_prev_not_peak[j];
                let from_prev_is_peak = dp_prev_is_peak[j];

                dp_curr_not_peak[j] = max(from_prev_not_peak, from_prev_is_peak);

                // Transition for dp_curr_is_peak[j] (nums[i] IS a peak)
                // An element nums[i] can only be a peak if 1 <= i <= n-2.
                if i >= 1 && i <= n - 2 {
                    // Calculate the cost to make nums[i] a peak.
                    // If it's already a peak, cost is 0. Otherwise, it costs 1 operation.
                    let cost_to_make_peak = if nums[i] > nums[i - 1] && nums[i] > nums[i + 1] {
                        0
                    } else {
                        1
                    };

                    // Check if we have enough operations remaining.
                    if j >= cost_to_make_peak {
                        let prev_ops_remaining = j - cost_to_make_peak;
                        let mut prev_max_peaks = -1;

                        // If nums[i] is a peak, then nums[i-1] cannot be a peak.
                        // This means the previous peak must have been at index i-2 or earlier.
                        // We look at the states for index i-2 (dp_prev_prev).
                        if i >= 2 { // If i-2 is a valid index (i.e., not before the start of the array)
                            prev_max_peaks = max(dp_prev_prev_not_peak[prev_ops_remaining], dp_prev_prev_is_peak[prev_ops_remaining]);
                        } else { // i = 1, this is the first possible peak.
                            // If i=1 is the first peak, there were 0 peaks before it.
                            // This is only valid if prev_ops_remaining is also 0 (meaning the cost was exactly j).
                            if prev_ops_remaining == 0 {
                                prev_max_peaks = 0;
                            } else {
                                prev_max_peaks = -1; // Cannot make a peak with this cost if no previous peaks and operations don't match
                            }
                        }

                        // If a valid previous state was found, update dp_curr_is_peak.
                        if prev_max_peaks != -1 {
                            dp_curr_is_peak[j] = max(dp_curr_is_peak[j], prev_max_peaks + 1);
                        }
                    }
                }
            }

            // Shift DP states for the next iteration:
            // dp_prev_prev becomes dp_prev
            // dp_prev becomes dp_curr
            dp_prev_prev_not_peak.copy_from_slice(&dp_prev_not_peak);
            dp_prev_prev_is_peak.copy_from_slice(&dp_prev_is_peak);
            dp_prev_not_peak.copy_from_slice(&dp_curr_not_peak);
            dp_prev_is_peak.copy_from_slice(&dp_curr_is_peak);
        }

        // The final answer is the maximum peaks found across all possible operations up to k.
        // We check the states for the last index (n-1).
        // Since nums[n-1] cannot be a peak, dp_prev_is_peak (which holds values for n-1)
        // will contain -1 for all j. So we only need to check dp_prev_not_peak.
        let mut max_peaks_overall = 0;
        for j in 0..=k_cap {
            max_peaks_overall = max(max_peaks_overall, dp_prev_not_peak[j]);
        }

        max_peaks_overall
    }
}