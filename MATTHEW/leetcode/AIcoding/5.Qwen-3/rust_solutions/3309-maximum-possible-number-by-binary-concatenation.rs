impl Solution {

use std::cmp::Ordering;
use std::collections::HashSet;

impl Solution {
    pub fn maxed_number(mut nums: Vec<i32>) -> i64 {
        nums.sort_by(|a, b| {
            let a_bin = format!("{:b}", *a);
            let b_bin = format!("{:b}", *b);
            match a_bin.len().cmp(&b_bin.len()) {
                Ordering::Equal => a_bin.cmp(&b_bin),
                other => other,
            }
        });

        let mut seen = HashSet::new();
        let mut result = String::new();

        for num in nums.iter().rev() {
            let bin = format!("{:b}", *num);
            if !seen.contains(&bin) {
                seen.insert(bin.clone());
                result.push_str(&bin);
            }
        }

        result.parse::<i64>().unwrap()
    }
}
}