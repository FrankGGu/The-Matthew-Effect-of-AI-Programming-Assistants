impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn count_days(mut days: Vec<Vec<i32>>, mut k: i32) -> i32 {
        let mut set = HashSet::new();
        for d in days {
            let start = d[0];
            let end = d[1];
            for i in start..=end {
                set.insert(i);
            }
        }
        let mut result = 0;
        let mut current = 1;
        while current <= k {
            if !set.contains(&current) {
                result += 1;
            }
            current += 1;
        }
        result
    }
}
}