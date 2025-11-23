impl Solution {

use std::cmp::Reverse;

impl Solution {
    pub fn maximum_happiness(mut happiness: Vec<i32>, k: i32) -> i64 {
        happiness.sort_by_key(|&x| Reverse(x));
        let mut total = 0;
        for i in 0..k as usize {
            if happiness[i] <= 0 {
                break;
            }
            total += happiness[i] as i64;
        }
        total
    }
}
}