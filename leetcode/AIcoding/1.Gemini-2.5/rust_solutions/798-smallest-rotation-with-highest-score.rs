impl Solution {
    pub fn best_rotation(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut delta: Vec<i32> = vec![0; n];

        for i in 0..n {
            let val = nums[i] as usize;
            // For nums[i], it contributes a point if its new index j satisfies j >= nums[i].
            // The new index j for rotation k is (i - k + n) % n.
            // So, we want (i - k + n) % n >= nums[i].
            //
            // Let's find the range of k for which this condition holds.
            // The new index j ranges from n-1 down to nums[i].
            // The k that maps to j is k = (i - j + n) % n.
            //
            // So, k ranges from (i - (n-1) + n) % n to (i - nums[i] + n) % n.
            // Let k_start_contrib = (i - (n-1) + n) % n = (i + 1) % n.
            // Let k_end_contrib = (i - nums[i] + n) % n.
            //
            // This defines a circular interval [k_start_contrib, k_end_contrib] where nums[i] contributes.
            // We use a difference array to mark the start and end of these intervals.
            //
            // If k_start_contrib <= k_end_contrib:
            //   The interval is [k_start_contrib, k_end_contrib].
            //   Score increases at k_start_contrib, decreases at (k_end_contrib + 1) % n.
            // Else (k_start_contrib > k_end_contrib, interval wraps around):
            //   The interval is [k_start_contrib, n-1] and [0, k_end_contrib].
            //   Score increases at k_start_contrib, decreases at (k_end_contrib + 1) % n.
            //   Additionally, score increases at 0 (for the [0, k_end_contrib] part).

            let k_start_contrib = (i + 1) % n;
            let k_end_contrib = (i as i32 - val as i32 + n as i32) as usize % n;

            if k_start_contrib <= k_end_contrib {
                delta[k_start_contrib] += 1;
                delta[(k_end_contrib + 1) % n] -= 1;
            } else { // Wraps around
                delta[k_start_contrib] += 1;
                delta[0] += 1; // For the segment starting from 0
                delta[(k_end_contrib + 1) % n] -= 1;
            }
        }

        // Calculate the score for k=0.
        // For k=0, new index is i. Condition is nums[i] <= i.
        let mut current_score = 0;
        for i in 0..n {
            if nums[i] <= i as i32 {
                current_score += 1;
            }
        }

        let mut max_score = current_score;
        let mut best_k = 0;

        // Calculate scores for k=1 to n-1 using the delta array.
        // score[k] = score[k-1] + delta[k].
        for k_idx in 1..n {
            current_score += delta[k_idx];
            if current_score > max_score {
                max_score = current_score;
                best_k = k_idx as i32;
            }
        }

        best_k
    }
}