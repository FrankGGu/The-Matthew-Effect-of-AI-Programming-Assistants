use std::collections::HashMap;

impl Solution {
    pub fn next_greater_element(nums1: Vec<i32>, nums2: Vec<i32>) -> Vec<i32> {
        let mut stack = Vec::new();
        let mut next_greater = HashMap::new();

        for &num in nums2.iter() {
            while let Some(&top) = stack.last() {
                if num > top {
                    next_greater.insert(top, num);
                    stack.pop();
                } else {
                    break;
                }
            }
            stack.push(num);
        }

        nums1.iter()
            .map(|&num| *next_greater.get(&num).unwrap_or(&-1))
            .collect()
    }
}