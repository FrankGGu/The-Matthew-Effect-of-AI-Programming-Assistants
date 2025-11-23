impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn optimal_division(nums: Vec<i32>) -> String {
        if nums.len() == 1 {
            return nums[0].to_string();
        }
        if nums.len() == 2 {
            return format!("{}{}", nums[0], nums[1]);
        }
        let mut result = String::new();
        result.push_str(&nums[0].to_string());
        result.push('/');
        let mut queue = VecDeque::new();
        for i in 1..nums.len() {
            queue.push_back(nums[i]);
        }
        while let Some(num) = queue.pop_front() {
            if queue.is_empty() {
                result.push_str(&num.to_string());
            } else {
                result.push('/');
                result.push_str(&num.to_string());
            }
        }
        result
    }
}
}