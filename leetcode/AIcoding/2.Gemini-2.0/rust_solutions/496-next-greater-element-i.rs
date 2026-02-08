impl Solution {
    pub fn next_greater_element(nums1: Vec<i32>, nums2: Vec<i32>) -> Vec<i32> {
        use std::collections::HashMap;
        let mut map = HashMap::new();
        let mut stack = Vec::new();
        for &num in nums2.iter() {
            while !stack.is_empty() && num > *stack.last().unwrap() {
                map.insert(stack.pop().unwrap(), num);
            }
            stack.push(num);
        }
        let mut result = Vec::new();
        for &num in nums1.iter() {
            result.push(*map.get(&num).unwrap_or(&-1));
        }
        result
    }
}