struct Solution;

impl Solution {
    pub fn sum_of_floored_pairs(nums: Vec<i32>) -> i32 {
        let max_val = *nums.iter().max().unwrap_or(&0) as usize;
        let modulo = 1_000_000_007;

        let mut counts = vec![0; max_val + 1];
        for &num in &nums {
            counts[num as usize] += 1;
        }

        let mut prefix_counts = vec![0; max_val + 1];
        // prefix_counts[v] stores the total count of numbers in nums that are less than or equal to v.
        // Since nums[i] >= 1, counts[0] will always be 0, so prefix_counts[0] will be 0.
        prefix_counts[0] = counts[0]; 
        for i in 1..=max_val {
            prefix_counts[i] = prefix_counts[i - 1] + counts[i];
        }

        let mut total_sum: i64 = 0;

        // Iterate through all possible values of nums[j], which we call 'x'.
        for x in 1..=max_val {
            if counts[x] == 0 {
                // If 'x' does not appear in nums, it cannot be nums[j], so skip.
                continue;
            }

            // Iterate through all possible values of floor(nums[i] / x), which we call 'k'.
            // k * x <= nums[i] < (k+1) * x
            for k in 1.. {
                let lower_bound = k * x;
                if lower_bound > max_val {
                    // If k*x exceeds max_val, no nums[i] can satisfy nums[i] >= k*x.
                    break;
                }

                let upper_bound = (k + 1) * x - 1;

                // Count how many nums[i] satisfy k*x <= nums[i] <= min(upper_bound, max_val).
                // This is equivalent to prefix_counts[min(upper_bound, max_val)] - prefix_counts[lower_bound - 1].
                let count_in_range = prefix_counts[std::cmp::min(upper_bound, max_val)] - prefix_counts[lower_bound - 1];

                // Add k * (count of nums[i] such that floor(nums[i]/x) = k) * (count of nums[j] = x)
                // All calculations are done with i64 to prevent overflow before applying modulo.
                let term = (k as i64 * count_in_range as i64) % modulo;
                let term_with_x_count = (term * counts[x] as i64) % modulo;
                total_sum = (total_sum + term_with_x_count) % modulo;
            }
        }

        total_sum as i32
    }
}