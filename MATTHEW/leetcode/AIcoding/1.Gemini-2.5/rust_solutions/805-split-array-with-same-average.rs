use std::collections::HashSet;

impl Solution {
    pub fn split_array_with_same_average(nums: Vec<i32>) -> bool {
        let n = nums.len();
        if n == 1 {
            return false;
        }

        let total_sum: i32 = nums.iter().sum();

        let half1_len = n / 2;
        let half2_len = n - half1_len;

        // dp1[k] stores all possible sums using k elements from the first half of `nums`.
        let mut dp1: Vec<HashSet<i32>> = vec![HashSet::new(); half1_len + 1];
        dp1[0].insert(0);

        // Generate sums for the first half
        for i in 0..half1_len {
            let num = nums[i];
            // Iterate k from current max possible count down to 1
            for k in (1..=i + 1).rev() {
                // Iterate over sums from (k-1) elements to form k-element sums
                for &s in &dp1[k - 1] {
                    dp1[k].insert(s + num);
                }
            }
        }

        // dp2[k] stores all possible sums using k elements from the second half of `nums`.
        let mut dp2: Vec<HashSet<i32>> = vec![HashSet::new(); half2_len + 1];
        dp2[0].insert(0);

        // Generate sums for the second half
        for i in half1_len..n {
            let num = nums[i];
            // Iterate k from current max possible count down to 1
            for k in (1..=(i - half1_len) + 1).rev() {
                // Iterate over sums from (k-1) elements to form k-element sums
                for &s in &dp2[k - 1] {
                    dp2[k].insert(s + num);
                }
            }
        }

        // Combine results from both halves
        for k1 in 0..=half1_len {
            for &s1 in &dp1[k1] {
                // k_total represents the total number of elements in sub-array A
                // It must be between 1 and n-1 to ensure both A and B are non-empty.
                for k_total in 1..n {
                    // Check if the target average (total_sum / n) can be achieved for a sub-array of length k_total
                    // This means (total_sum * k_total) must be divisible by n
                    if (total_sum * k_total as i32) % n as i32 != 0 {
                        continue;
                    }

                    let required_sum_for_k = (total_sum * k_total as i32) / n as i32;
                    let k2 = k_total - k1;

                    // Ensure k2 is a valid count for the second half
                    if k2 < 0 || k2 > half2_len {
                        continue;
                    }

                    let s2_target = required_sum_for_k - s1;

                    // Check if dp2 contains the required sum for k2 elements
                    if dp2[k2].contains(&s2_target) {
                        return true;
                    }
                }
            }
        }

        false
    }
}