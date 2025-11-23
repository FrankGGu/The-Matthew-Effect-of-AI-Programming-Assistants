struct Solution;

impl Solution {
    pub fn divide(dividend: i32, divisor: i32) -> i32 {
        if dividend == i32::MIN && divisor == -1 {
            return i32::MAX;
        }

        let mut a = dividend.abs() as i64;
        let mut b = divisor.abs() as i64;
        let mut res = 0;

        while a >= b {
            let mut temp = b;
            let mut i = 0;
            while a >= temp {
                temp <<= 1;
                i += 1;
            }
            res += 1 << (i - 1);
            a -= (1 << (i - 1)) * b;
        }

        if (dividend < 0) ^ (divisor < 0) {
            -res as i32
        } else {
            res as i32
        }
    }
}