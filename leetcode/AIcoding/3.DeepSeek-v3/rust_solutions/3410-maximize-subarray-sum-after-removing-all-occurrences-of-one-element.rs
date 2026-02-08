use std::collections::HashMap;

impl Solution {
    pub fn maximum_sum(nums: Vec<i32>) -> i32 {
        let mut sum_map: HashMap<i32, i32> = HashMap::new();
        let mut max_sum = i32::MIN;
        let mut current_sum = 0;
        let mut min_neg = i32::MAX;

        for &num in &nums {
            current_sum += num;
            if num < 0 {
                if num < min_neg {
                    min_neg = num;
                }
            }
            *sum_map.entry(num).or_insert(0) += num;
        }

        if min_neg != i32::MAX {
            for (key, &sum) in sum_map.iter() {
                let temp_sum = current_sum - sum;
                if temp_sum > max_sum {
                    max_sum = temp_sum;
                }
            }
            max_sum.max(current_sum - min_neg)
        } else {
            current_sum
        }
    }
}