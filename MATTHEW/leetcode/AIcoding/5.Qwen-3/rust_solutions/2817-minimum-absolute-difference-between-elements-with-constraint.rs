impl Solution {

use std::cmp::Ordering;
use std::collections::HashSet;

impl Solution {
    pub fn min_absolute_difference(arr: Vec<i32>, a: i32, b: i32) -> i32 {
        let mut set = HashSet::new();
        let mut min_diff = i32::MAX;

        for &num in &arr {
            if set.contains(&(num - a)) || set.contains(&(num - b)) {
                min_diff = min_diff.min((num - (num - a)).abs().min((num - (num - b)).abs()));
            }
            set.insert(num);
        }

        min_diff
    }
}
}