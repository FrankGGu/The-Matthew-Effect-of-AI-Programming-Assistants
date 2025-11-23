use std::collections::HashMap;

impl Solution {
    pub fn median_of_uniqueness_array(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let total_subarrays = n * (n + 1) / 2;
        let k = (total_subarrays + 1) / 2;

        let mut left = 1;
        let mut right = n as i32;
        let mut answer = n as i32;

        while left <= right {
            let mid = left + (right - left) / 2;
            if Self::count_subarrays_with_at_most_k_distinct(&nums, mid) >= k {
                answer = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        answer
    }

    fn count_subarrays_with_at_most_k_distinct(nums: &[i32], k: i32) -> usize {
        let mut count = 0;
        let mut freq = HashMap::new();
        let mut left = 0;
        let mut distinct = 0;

        for right in 0..nums.len() {
            *freq.entry(nums[right]).or_insert(0) += 1;
            if freq[&nums[right]] == 1 {
                distinct += 1;
            }

            while distinct > k {
                *freq.get_mut(&nums[left]).unwrap() -= 1;
                if freq[&nums[left]] == 0 {
                    distinct -= 1;
                }
                left += 1;
            }

            count += right - left + 1;
        }

        count
    }
}