impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn count_largest_group(n: i32) -> i32 {
        let mut group = HashMap::new();
        for i in 1..=n {
            let sum = i.to_string().chars().map(|c| c.to_digit(10).unwrap()).sum::<u32>();
            *group.entry(sum).or_insert(0) += 1;
        }
        let max_size = group.values().max().copied().unwrap();
        group.values().filter(|&&size| size == max_size).count() as i32
    }
}
}