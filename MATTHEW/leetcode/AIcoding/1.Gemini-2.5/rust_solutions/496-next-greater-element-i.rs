use std::collections::HashMap;

impl Solution {
    pub fn next_greater_element(nums1: Vec<i32>, nums2: Vec<i32>) -> Vec<i32> {
        let mut next_greater_map: HashMap<i32, i32> = HashMap::new();
        let mut stack: Vec<i32> = Vec::new();

        for &num in nums2.iter() {
            while let Some(&top) = stack.last() {
                if top < num {
                    next_greater_map.insert(stack.pop().unwrap(), num);
                } else {
                    break;
                }
            }
            stack.push(num);
        }

        let mut result: Vec<i32> = Vec::with_capacity(nums1.len());
        for &num1 in nums1.iter() {
            result.push(*next_greater_map.get(&num1).unwrap_or(&-1));
        }

        result
    }
}