use std::collections::HashMap;

impl Solution {
    pub fn subarrays_with_k_distinct(nums: Vec<i32>, k: i32) -> i32 {
        Self::count_at_most_k_distinct(&nums, k) - Self::count_at_most_k_distinct(&nums, k - 1)
    }

    fn count_at_most_k_distinct(nums: &Vec<i32>, k: i32) -> i32 {
        if k == 0 {
            return 0;
        }

        let n = nums.len();
        let mut freq = vec![0; n + 1];
        let mut distinct_count = 0;
        let mut left = 0;
        let mut ans = 0;

        for right in 0..n {
            let num_r = nums[right] as usize;
            if freq[num_r] == 0 {
                distinct_count += 1;
            }
            freq[num_r] += 1;

            while distinct_count > k {
                let num_l = nums[left] as usize;
                freq[num_l] -= 1;
                if freq[num_l] == 0 {
                    distinct_count -= 1;
                }
                left += 1;
            }
            ans += (right - left + 1) as i32;
        }
        ans
    }
}