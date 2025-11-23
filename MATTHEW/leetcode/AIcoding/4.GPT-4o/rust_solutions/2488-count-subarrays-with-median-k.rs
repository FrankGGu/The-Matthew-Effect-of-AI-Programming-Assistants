use std::collections::HashMap;

impl Solution {
    pub fn count_subarrays(array: Vec<i32>, k: i32) -> i32 {
        let mut count_map = HashMap::new();
        let mut count = 0;
        let mut balance = 0;

        for &num in &array {
            if num < k {
                balance -= 1;
            } else if num > k {
                balance += 1;
            }

            if num == k {
                count += count_map.get(&balance).unwrap_or(&0) + 1;
            } else {
                count += count_map.get(&(balance - 1)).unwrap_or(&0);
            }

            *count_map.entry(balance).or_insert(0) += 1;
        }

        count
    }
}