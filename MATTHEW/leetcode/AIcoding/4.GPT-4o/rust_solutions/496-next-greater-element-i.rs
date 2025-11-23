impl Solution {
    pub fn next_greater_element(nums1: Vec<i32>, nums2: Vec<i32>) -> Vec<i32> {
        let mut map = std::collections::HashMap::new();
        let mut stack = Vec::new();

        for &num in nums2.iter() {
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

        nums1.iter().map(|&num| map.get(&num).copied().unwrap_or(-1)).collect()
    }
}