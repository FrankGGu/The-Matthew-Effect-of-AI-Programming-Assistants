use std::collections::HashMap;

impl Solution {
    pub fn find_lucky(arr: Vec<i32>) -> i32 {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for &num in &arr {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut lucky_numbers: Vec<i32> = Vec::new();
        for (&num, &count) in &counts {
            if num == count {
                lucky_numbers.push(num);
            }
        }

        if lucky_numbers.is_empty() {
            return -1;
        } else {
            return *lucky_numbers.iter().max().unwrap();
        }
    }
}