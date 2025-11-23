impl Solution {

use std::collections::BTreeSet;

impl Solution {
    pub fn count_groups(ranges: Vec<Vec<i32>>) -> i32 {
        let mut sorted = ranges;
        sorted.sort_by(|a, b| a[0].cmp(&b[0]));

        let mut result = 0;
        let mut end = -1;

        for range in sorted {
            if range[0] > end {
                result += 1;
                end = range[1];
            }
        }

        result
    }
}
}