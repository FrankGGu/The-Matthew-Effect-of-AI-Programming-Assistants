impl Solution {
    pub fn divide_array(nums: Vec<i32>) -> bool {
        use std::collections::HashMap;
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for &num in &nums {
            *counts.entry(num).or_insert(0) += 1;
        }
        for &count in counts.values() {
            if count % 2 != 0 {
                return false;
            }
        }
        true
    }
}