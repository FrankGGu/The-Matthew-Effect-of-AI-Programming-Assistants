impl Solution {
    pub fn min_operations(mut nums1: Vec<i32>, mut nums2: Vec<i32>) -> i32 {
        let n1_len = nums1.len();
        let n2_len = nums2.len();

        // Check for impossible cases based on array lengths.
        // If the maximum possible sum of one array is less than the minimum possible sum of the other,
        // it's impossible to make them equal.
        // max_sum_array_1 = n1_len * 6
        // min_sum_array_2 = n2_len * 1
        // If n1_len * 6 < n2_len * 1, it's impossible.
        // Similarly, if n2_len * 6 < n1_len * 1, it's impossible.
        if 6 * n1_len < n2_len || 6 * n2_len < n1_len {
            return -1;
        }

        let mut sum1: i32 = nums1.iter().sum();
        let mut sum2: i32 = nums2.iter().sum();

        if sum1 == sum2 {
            return 0;
        }

        // Ensure sum1 is always the smaller sum. This simplifies the logic
        // so we always aim to increase sum1 or decrease sum2.
        if sum1 > sum2 {
            std::mem::swap(&mut nums1, &mut nums2);
            std::mem::swap(&mut sum1, &mut sum2);
        }

        // Now sum1 < sum2. We need to reduce the difference (sum2 - sum1).
        // An operation consists of changing an element x to 1 or 6.
        // To increase sum1: change x to 6. Gain: 6 - x. (Max gain 5 from changing 1 to 6)
        // To decrease sum2: change y to 1. Gain: y - 1. (Max gain 5 from changing 6 to 1)
        // We want to maximize the gain in each step.

        // `gains_counts[k]` will store the number of elements that can contribute a gain of `k`.
        // Possible gains range from 1 to 5.
        let mut gains_counts = [0; 6]; 

        // Populate gains_counts for elements in nums1 (to increase sum1)
        // For an element `x` in `nums1`, changing it to `6` gives a gain of `6 - x`.
        // We only consider `x < 6` because `x=6` gives 0 gain.
        for &x in nums1.iter() {
            gains_counts[(6 - x) as usize] += 1;
        }

        // Populate gains_counts for elements in nums2 (to decrease sum2)
        // For an element `y` in `nums2`, changing it to `1` gives a gain of `y - 1`.
        // We only consider `y > 1` because `y=1` gives 0 gain.
        for &y in nums2.iter() {
            gains_counts[(y - 1) as usize] += 1;
        }

        let mut operations = 0;
        let mut diff = sum2 - sum1;

        // Iterate from the highest possible gain (5) down to 1.
        // Greedily apply operations with the largest gains first.
        for gain in (1..=5).rev() {
            if diff <= 0 {
                break; // Difference is covered or overshot, we are done.
            }

            let num_available_ops = gains_counts[gain as usize];
            if num_available_ops == 0 {
                continue; // No elements can provide this gain.
            }

            // Calculate how many operations of this specific 'gain' value are needed
            // to cover the remaining 'diff'. This is ceil(diff / gain).
            let num_needed_for_diff = (diff + gain - 1) / gain;

            // Take the minimum of available operations and needed operations.
            let num_to_take = num_available_ops.min(num_needed_for_diff);

            diff -= num_to_take * gain;
            operations += num_to_take;
        }

        operations
    }
}