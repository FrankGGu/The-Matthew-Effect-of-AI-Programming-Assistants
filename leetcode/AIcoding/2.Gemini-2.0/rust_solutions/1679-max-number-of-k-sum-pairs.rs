use std::collections::HashMap;

impl Solution {
    pub fn max_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut count: HashMap<i32, i32> = HashMap::new();
        let mut operations = 0;

        for &num in &nums {
            let complement = k - num;
            if let Some(&complement_count) = count.get(&complement) {
                if complement_count > 0 {
                    operations += 1;
                    *count.entry(complement).or_insert(0) -= 1;
                } else {
                    *count.entry(num).or_insert(0) += 1;
                }
            } else {
                *count.entry(num).or_insert(0) += 1;
            }
        }

        operations
    }
}