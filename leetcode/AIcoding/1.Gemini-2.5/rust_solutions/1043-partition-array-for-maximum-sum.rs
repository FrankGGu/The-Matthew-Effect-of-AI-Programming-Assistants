impl Solution {
    pub fn max_sum_after_partitioning(arr: Vec<i32>, k: i32) -> i32 {
        let n = arr.len();
        let k = k as usize; 

        // dp[i] stores the maximum sum for the subarray arr[0...i-1]
        // dp array size will be n + 1, with dp[0] initialized to 0 (base case for an empty prefix)
        let mut dp = vec![0; n + 1];

        // Iterate through each possible end point of the subarray (from index 0 to n-1)
        // 'i' represents the length of the current prefix arr[0...i-1]
        for i in 1..=n {
            let mut max_val_in_current_segment = 0;

            // Iterate through possible lengths 'j' of the last partition (segment ending at i-1)
            // 'j' can range from 1 up to k, but also cannot exceed the current prefix length 'i'.
            for j in 1..=k.min(i) {
                // Calculate the start index of the current segment (last partition)
                // This segment is arr[i-j ... i-1]
                let current_segment_start_idx = i - j;

                // Find the maximum value in the current segment arr[current_segment_start_idx ... i-1]
                // As 'j' increases, current_segment_start_idx decreases, extending the segment to the left.
                // We update max_val_in_current_segment with the new element arr[current_segment_start_idx].
                max_val_in_current_segment = max_val_in_current_segment.max(arr[current_segment_start_idx]);

                // Calculate the potential maximum sum for dp[i] by considering this partition:
                // dp[i - j] (maximum sum for the prefix before the current segment)
                // + max_val_in_current_segment * (j as i32) (sum for the current segment, where all elements are replaced by max_val)
                dp[i] = dp[i].max(dp[current_segment_start_idx] + max_val_in_current_segment * (j as i32));
            }
        }

        // The maximum sum for the entire array arr[0...n-1] is stored in dp[n]
        dp[n]
    }
}