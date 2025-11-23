impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_good_partitions(s: String) -> i32 {
        let mut last_occurrence = HashMap::new();
        for (i, c) in s.chars().enumerate() {
            last_occurrence.insert(c, i);
        }

        let mut count = 0;
        let mut end = 0;
        let mut start = 0;

        for i in 0..s.len() {
            end = std::cmp::max(end, *last_occurrence.get(&s.chars().nth(i).unwrap()).unwrap());
            if i == end {
                count += 1;
                start = i + 1;
            }
        }

        count
    }
}
}