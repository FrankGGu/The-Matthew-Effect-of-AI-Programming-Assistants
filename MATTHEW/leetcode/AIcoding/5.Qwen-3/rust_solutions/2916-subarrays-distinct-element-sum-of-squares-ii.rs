impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn sum_squares(nums: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        let mut result = 0;
        let mut left = 0;

        for right in 0..nums.len() {
            let num = nums[right];
            *count.entry(num).or_insert(0) += 1;

            while count[&num] > 1 {
                let left_num = nums[left];
                *count.get_mut(&left_num).unwrap() -= 1;
                if *count.get_mut(&left_num).unwrap() == 0 {
                    count.remove(&left_num);
                }
                left += 1;
            }

            let current = count.values().map(|&v| v * v).sum::<i32>();
            result += current;
        }

        result
    }
}
}