use std::collections::HashMap;

impl Solution {
    pub fn find_lucky(arr: Vec<i32>) -> i32 {
        let mut frequency = HashMap::new();
        for &num in &arr {
            *frequency.entry(num).or_insert(0) += 1;
        }
        let mut max_lucky = -1;
        for (&num, &count) in &frequency {
            if num == count {
                max_lucky = max_lucky.max(num);
            }
        }
        max_lucky
    }
}