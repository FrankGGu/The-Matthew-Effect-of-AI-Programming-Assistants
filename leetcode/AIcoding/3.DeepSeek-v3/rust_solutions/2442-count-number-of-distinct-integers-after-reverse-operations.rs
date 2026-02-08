use std::collections::HashSet;

impl Solution {
    pub fn count_distinct_integers(nums: Vec<i32>) -> i32 {
        let mut distinct = HashSet::new();
        for &num in &nums {
            distinct.insert(num);
            let reversed = num.to_string().chars().rev().collect::<String>().parse::<i32>().unwrap_or(0);
            distinct.insert(reversed);
        }
        distinct.len() as i32
    }
}