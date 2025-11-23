impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_operations(fruits: Vec<i32>, k: i32) -> i32 {
        let mut count = HashMap::new();
        for &fruit in &fruits {
            *count.entry(fruit).or_insert(0) += 1;
        }

        let mut operations = 0;
        for (_, &freq) in &count {
            if freq > 1 {
                operations += (freq - 1) * k;
            }
        }

        operations
    }
}
}