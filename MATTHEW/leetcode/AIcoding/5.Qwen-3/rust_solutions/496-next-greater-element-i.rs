impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn next_greater_element(nums1: Vec<i32>, nums2: Vec<i32>) -> Vec<i32> {
        let mut map = HashMap::new();
        let mut stack = Vec::new();

        for num in nums2 {
            while let Some(&top) = stack.last() {
                if top < num {
                    map.insert(top, num);
                    stack.pop();
                } else {
                    break;
                }
            }
            stack.push(num);
        }

        nums1.into_iter().map(|x| *map.get(&x).unwrap_or(&-1)).collect()
    }
}
}