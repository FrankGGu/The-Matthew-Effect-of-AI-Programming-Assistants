impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn minimum_number_of_magic_beans(mut beans: Vec<i32>) -> i64 {
        beans.sort();
        let n = beans.len();
        let mut sum: i64 = beans.iter().map(|&x| x as i64).sum();
        let mut max_remaining = 0;

        for i in 0..n {
            let current = beans[i] as i64 * (n - i) as i64;
            max_remaining = max_remaining.max(current);
        }

        (sum - max_remaining) as i64
    }
}
}