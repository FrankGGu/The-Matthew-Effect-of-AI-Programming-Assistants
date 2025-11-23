use std::collections::HashMap;

impl Solution {
    pub fn most_frequent_even(nums: Vec<i32>) -> i32 {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for &num in &nums {
            if num % 2 == 0 {
                *counts.entry(num).or_insert(0) += 1;
            }
        }

        let mut most_frequent = -1;
        let mut max_count = 0;

        for (&num, &count) in &counts {
            if count > max_count {
                max_count = count;
                most_frequent = num;
            } else if count == max_count && num < most_frequent {
                most_frequent = num;
            }
        }

        most_frequent
    }
}