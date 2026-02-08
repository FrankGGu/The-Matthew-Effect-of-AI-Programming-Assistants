impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        let mut s = std::collections::HashSet::new();
        for &num in &nums {
            if num > 0 {
                s.insert(num);
            }
        }
        s.len() as i32
    }
}