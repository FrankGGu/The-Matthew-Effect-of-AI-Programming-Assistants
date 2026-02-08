use std::collections::HashMap;
use std::vec::Vec;

impl Solution {
    pub fn next_greater_elements(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut result = vec![-1; n];
        let mut stack = Vec::new();
        let mut num_map = HashMap::new();

        for &num in &nums {
            *num_map.entry(num).or_insert(0) += 1;
        }

        for i in (0..(2 * n)).rev() {
            let index = i % n;
            while let Some(&top) = stack.last() {
                if top > nums[index] {
                    result[index] = top;
                    break;
                }
                stack.pop();
            }
            stack.push(nums[index]);
        }

        for i in 0..n {
            if result[i] != -1 {
                num_map.remove(&result[i]);
            }
        }

        for i in 0..n {
            if result[i] == -1 {
                if let Some(&next_greater) = num_map.keys().find(|&&x| x > nums[i]) {
                    result[i] = next_greater;
                }
            }
        }

        result
    }
}