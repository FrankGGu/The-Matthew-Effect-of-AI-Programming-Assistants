impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn max_number_of_alloys(mut k: i32, mut q: i32, mut a: Vec<i32>, mut m: i32) -> i32 {
        a.sort_unstable();
        let mut left = 0;
        let mut right = 1000000000;
        while left < right {
            let mid = (left + right + 1) / 2;
            let mut total = 0;
            for &x in &a {
                let need = (mid - x + k - 1) / k;
                if need < 0 {
                    continue;
                }
                total += need;
                if total > m {
                    break;
                }
            }
            match total.cmp(&m) {
                Ordering::Less => left = mid,
                _ => right = mid - 1,
            }
        }
        left
    }
}
}