impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn count_of_powerful_integers(a: i32, b: i32, max_sum: i32) -> i32 {
        let mut result = HashSet::new();
        let mut x = 0;
        loop {
            let mut y = 0;
            loop {
                let sum = a.pow(x) + b.pow(y);
                if sum > max_sum {
                    break;
                }
                result.insert(sum);
                y += 1;
                if y > 20 {
                    break;
                }
            }
            x += 1;
            if x > 20 {
                break;
            }
        }
        result.len() as i32
    }
}
}