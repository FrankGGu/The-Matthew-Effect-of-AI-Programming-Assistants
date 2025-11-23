use std::cmp::max;

impl Solution {
    pub fn minimize_set(d1: i32, d2: i32, unique_cnt1: i32, unique_cnt2: i32) -> i32 {
        let (d1, d2, unique_cnt1, unique_cnt2) = (d1 as i64, d2 as i64, unique_cnt1 as i64, unique_cnt2 as i64);
        let lcm_val = lcm(d1, d2);
        let mut left = 0;
        let mut right = i64::MAX / 2;

        while left < right {
            let mid = left + (right - left) / 2;
            let cnt1 = mid / d1;
            let cnt2 = mid / d2;
            let common = mid / lcm_val;

            let total = mid;
            let avail1 = mid - cnt2 + common;
            let avail2 = mid - cnt1 + common;
            let avail_common = mid - cnt1 - cnt2 + common;

            if avail1 >= unique_cnt1 && avail2 >= unique_cnt2 && avail1 + avail2 - avail_common >= unique_cnt1 + unique_cnt2 {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        left as i32
    }
}

fn gcd(a: i64, b: i64) -> i64 {
    if b == 0 { a } else { gcd(b, a % b) }
}

fn lcm(a: i64, b: i64) -> i64 {
    a * b / gcd(a, b)
}