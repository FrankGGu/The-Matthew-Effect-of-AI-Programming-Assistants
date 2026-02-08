use std::collections::HashMap;

impl Solution {
    pub fn maximum_subarray_sum(nums: Vec<i32>, k: i32) -> i64 {
        let k = k as usize;
        let n = nums.len();
        if n < k {
            return 0;
        }

        let mut max_sum: i64 = 0;
        let mut current_sum: i64 = 0;
        let mut counts: HashMap<i32, i32> = HashMap::new();

        for i in 0..k {
            current_sum += nums[i] as i64;
            *counts.entry(nums[i]).or_insert(0) += 1;
        }

        if counts.len() == k {
            max_sum = max_sum.max(current_sum);
        }

        for i in k..n {
            let old_val = nums[i - k];
            current_sum -= old_val as i64;
            *counts.get_mut(&old_val).unwrap() -= 1;
            if *counts.get(&old_val).unwrap() == 0 {
                counts.remove(&old_val);
            }

            let new_val = nums[i];
            current_sum += new_val as i64;
            *counts.entry(new_val).or_insert(0) += 1;

            if counts.len() == k {
                max_sum = max_sum.max(current_sum);
            }
        }

        max_sum
    }
}