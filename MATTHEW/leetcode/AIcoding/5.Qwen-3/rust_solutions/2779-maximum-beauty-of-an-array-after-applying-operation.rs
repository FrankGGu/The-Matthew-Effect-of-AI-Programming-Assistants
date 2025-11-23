impl Solution {

use std::cmp::Ordering;
use std::collections::BTreeSet;

impl Solution {
    pub fn maximum_beauty(mut nums: Vec<i32>, k: i32) -> i32 {
        let mut events = Vec::new();
        for &num in &nums {
            events.push((num - k, 1));
            events.push((num + k + 1, -1));
        }
        events.sort_by(|a, b| {
            if a.0 != b.0 {
                a.0.cmp(&b.0)
            } else {
                a.1.cmp(&b.1)
            }
        });

        let mut max_beauty = 0;
        let mut current = 0;
        let mut prev = 0;

        for (pos, delta) in events {
            if pos > prev {
                max_beauty = max_beauty.max(current);
            }
            current += delta;
            prev = pos;
        }

        max_beauty
    }
}
}