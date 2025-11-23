use std::collections::BinaryHeap;

impl Solution {
    pub fn next_greater_elements(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut result = vec![-1; n];
        let mut stack1: Vec<usize> = Vec::new();
        let mut stack2: BinaryHeap<(i32, usize)> = BinaryHeap::new();

        for i in 0..n {
            while let Some(&(val, idx)) = stack2.peek() {
                if val < nums[i] {
                    result[idx] = nums[i];
                    stack2.pop();
                } else {
                    break;
                }
            }

            while let Some(&idx) = stack1.last() {
                if nums[idx] < nums[i] {
                    stack1.pop();
                    stack2.push((nums[idx], idx));
                } else {
                    break;
                }
            }
            stack1.push(i);
        }

        result
    }
}