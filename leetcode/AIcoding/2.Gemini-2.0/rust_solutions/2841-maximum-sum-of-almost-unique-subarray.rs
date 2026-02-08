use std::collections::HashMap;

impl Solution {
    pub fn max_sum_subarray(nums: Vec<i32>, m: i32, k: i32) -> i64 {
        let n = nums.len();
        let mut max_sum: i64 = 0;
        let mut current_sum: i64 = 0;
        let mut freq: HashMap<i32, i32> = HashMap::new();
        let mut unique_count: i32 = 0;

        for i in 0..n {
            let num = nums[i];
            let count = freq.entry(num).or_insert(0);
            if *count == 0 {
                unique_count += 1;
            }
            *count += 1;
            current_sum += num as i64;

            if i >= k as usize {
                let num_remove = nums[i - k as usize];
                let count_remove = freq.get_mut(&num_remove).unwrap();
                *count_remove -= 1;
                if *count_remove == 0 {
                    unique_count -= 1;
                }
                current_sum -= num_remove as i64;
            }

            if i >= (k - 1) as usize && unique_count >= m {
                max_sum = max_sum.max(current_sum);
            }
        }

        max_sum
    }
}