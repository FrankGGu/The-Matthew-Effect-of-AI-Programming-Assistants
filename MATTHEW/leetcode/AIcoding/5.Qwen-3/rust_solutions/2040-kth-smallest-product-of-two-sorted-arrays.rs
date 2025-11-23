pub struct Solution {}

impl Solution {
    pub fn kth_smallest_product(a: Vec<i32>, b: Vec<i32>, k: i64) -> i32 {
        use std::cmp::Ordering;

        fn count_less_or_equal(a: &[i32], b: &[i32], val: i64) -> i64 {
            let mut count = 0;
            let mut j = b.len() as i64 - 1;
            for &x in a.iter() {
                if x >= 0 {
                    while j >= 0 && (x as i64) * (b[j as usize] as i64) > val {
                        j -= 1;
                    }
                    count += j + 1;
                } else {
                    while j >= 0 && (x as i64) * (b[j as usize] as i64) <= val {
                        j -= 1;
                    }
                    count += (b.len() as i64 - j - 1);
                }
            }
            count
        }

        let mut left = -10_i64.pow(5) * 10_i64.pow(5);
        let mut right = 10_i64.pow(5) * 10_i64.pow(5);

        while left < right {
            let mid = left + (right - left) / 2;
            let cnt = count_less_or_equal(&a, &b, mid);
            if cnt < k {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        left as i32
    }
}