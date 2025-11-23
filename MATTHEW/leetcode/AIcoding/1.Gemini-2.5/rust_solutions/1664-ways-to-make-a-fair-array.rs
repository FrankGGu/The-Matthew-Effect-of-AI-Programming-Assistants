impl Solution {
    pub fn ways_to_make_fair(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }

        let mut total_even_sum = 0;
        let mut total_odd_sum = 0;

        for k in 0..n {
            if k % 2 == 0 {
                total_even_sum += nums[k];
            } else {
                total_odd_sum += nums[k];
            }
        }

        let mut count = 0;
        let mut current_even_sum_prefix = 0;
        let mut current_odd_sum_prefix = 0;

        for i in 0..n {
            let mut even_sum_after_i;
            let mut odd_sum_after_i;

            // Calculate sums of elements after current index i, before considering removal
            // These sums include nums[i] if its parity matches.
            let even_sum_from_i_onwards = total_even_sum - current_even_sum_prefix;
            let odd_sum_from_i_onwards = total_odd_sum - current_odd_sum_prefix;

            if i % 2 == 0 { // nums[i] is at an even index
                // Remove nums[i] from the even sum of elements from i onwards
                even_sum_after_i = even_sum_from_i_onwards - nums[i];
                // odd_sum_from_i_onwards does not include nums[i], so it's directly odd_sum_after_i
                odd_sum_after_i = odd_sum_from_i_onwards;
            } else { // nums[i] is at an odd index
                // even_sum_from_i_onwards does not include nums[i], so it's directly even_sum_after_i
                even_sum_after_i = even_sum_from_i_onwards;
                // Remove nums[i] from the odd sum of elements from i onwards
                odd_sum_after_i = odd_sum_from_i_onwards - nums[i];
            }

            // When nums[i] is removed, elements at original indices j > i shift to j-1.
            // This means their parity flips.
            // Elements that were at even indices after i now contribute to the new odd sum.
            // Elements that were at odd indices after i now contribute to the new even sum.
            let new_even_sum = current_even_sum_prefix + odd_sum_after_i;
            let new_odd_sum = current_odd_sum_prefix + even_sum_after_i;

            if new_even_sum == new_odd_sum {
                count += 1;
            }

            // Update prefix sums for the next iteration by adding nums[i]
            if i % 2 == 0 {
                current_even_sum_prefix += nums[i];
            } else {
                current_odd_sum_prefix += nums[i];
            }
        }

        count
    }
}