use std::cmp::min;

impl Solution {
    pub fn nth_ugly_number(n: i32) -> i32 {
        let n = n as usize;
        let mut ugly = vec![1; n];
        let (mut i2, mut i3, mut i5) = (0, 0, 0);

        for i in 1..n {
            let next_ugly = min(ugly[i2] * 2, min(ugly[i3] * 3, ugly[i5] * 5));
            ugly[i] = next_ugly;

            if next_ugly == ugly[i2] * 2 { i2 += 1; }
            if next_ugly == ugly[i3] * 3 { i3 += 1; }
            if next_ugly == ugly[i5] * 5 { i5 += 1; }
        }

        ugly[n - 1]
    }
}