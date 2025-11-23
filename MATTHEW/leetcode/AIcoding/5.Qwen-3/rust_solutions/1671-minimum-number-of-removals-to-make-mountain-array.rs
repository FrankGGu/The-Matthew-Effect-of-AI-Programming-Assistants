impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn minimum_removals(a: Vec<i32>) -> i32 {
        let n = a.len();
        if n < 3 {
            return 0;
        }

        let mut inc = vec![1; n];
        let mut dec = vec![1; n];

        for i in 1..n {
            for j in 0..i {
                if a[j] < a[i] {
                    inc[i] = inc[i].max(inc[j] + 1);
                }
            }
        }

        for i in (0..n).rev() {
            for j in (i + 1)..n {
                if a[j] < a[i] {
                    dec[i] = dec[i].max(dec[j] + 1);
                }
            }
        }

        let mut max_len = 0;
        for i in 0..n {
            if inc[i] > 1 && dec[i] > 1 {
                max_len = max_len.max(inc[i] + dec[i] - 1);
            }
        }

        (n as i32 - max_len) as i32
    }
}
}