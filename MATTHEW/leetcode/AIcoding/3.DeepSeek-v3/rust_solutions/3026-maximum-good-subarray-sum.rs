use std::collections::HashMap;

impl Solution {
    pub fn maximum_subarray_sum(nums: Vec<i32>, k: i32) -> i64 {
        let k = k as i64;
        let mut prefix_sum = 0i64;
        let mut sum_map = HashMap::new();
        sum_map.insert(0, -1);
        let mut max_sum = i64::MIN;

        for (i, &num) in nums.iter().enumerate() {
            prefix_sum += num as i64;
            let target1 = prefix_sum - k;
            let target2 = prefix_sum + k;

            if let Some(&idx) = sum_map.get(&target1) {
                let current_sum = prefix_sum - target1;
                if current_sum > max_sum {
                    max_sum = current_sum;
                }
            }

            if let Some(&idx) = sum_map.get(&target2) {
                let current_sum = prefix_sum - target2;
                if current_sum > max_sum {
                    max_sum = current_sum;
                }
            }

            if !sum_map.contains_key(&prefix_sum) {
                sum_map.insert(prefix_sum, i as i32);
            }
        }

        if max_sum == i64::MIN { 0 } else { max_sum }
    }
}