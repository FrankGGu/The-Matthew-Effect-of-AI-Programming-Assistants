struct Solution;

impl Solution {
    pub fn min_flips(a: i32, b: i32, c: i32) -> i32 {
        let mut flips = 0;
        let mut a_bit = a;
        let mut b_bit = b;
        let mut c_bit = c;

        while a_bit > 0 || b_bit > 0 || c_bit > 0 {
            let a_last = a_bit & 1;
            let b_last = b_bit & 1;
            let c_last = c_bit & 1;

            if (a_last | b_last) != c_last {
                if c_last == 1 {
                    flips += 1;
                } else {
                    flips += a_last + b_last;
                }
            }

            a_bit >>= 1;
            b_bit >>= 1;
            c_bit >>= 1;
        }

        flips
    }
}