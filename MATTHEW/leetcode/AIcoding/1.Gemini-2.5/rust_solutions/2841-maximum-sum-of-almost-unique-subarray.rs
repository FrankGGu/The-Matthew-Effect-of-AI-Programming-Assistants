use std::collections::HashMap;
use std::cmp::max;

impl Solution {
    pub fn maximum_sum_of_almost_unique_subarray(nums: Vec<i32>, m: i32, k: i32) -> i64 {
        let n = nums.len();
        let m_usize = m as usize;
        let k_usize = k as usize;

        let mut max_sum: i64 = 0;
        let mut current_sum: i64 = 0;
        let mut freq_map: HashMap<i32, i32> = HashMap::new();

        for i in 0..k_usize {
            current_sum += nums[i] as i64;
            *freq_map.entry(nums[i]).or_insert(0) += 1;
        }

        if freq_map.len() >= m_usize {
            max_sum = current_sum;
        }

        for i in k_usize..n {
            let left_val = nums[i - k_usize];
            current_sum -= left_val as i64;
            *freq_map.get_mut(&left_val).unwrap() -= 1;
            if *freq_map.get(&left_val).unwrap() == 0 {
                freq_map.remove(&left_val);
            }

            let right_val = nums[i];
            current_sum += right_val as i64;
            *freq_map.entry(right_val).or_insert(0) += 1;

            if freq_map.len() >= m_usize {
                max_sum = max(max_sum, current_sum);
            }
        }

        max_sum
    }
}