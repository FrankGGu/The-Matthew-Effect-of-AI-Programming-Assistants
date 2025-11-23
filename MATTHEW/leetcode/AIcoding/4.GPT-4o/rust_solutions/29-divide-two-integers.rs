impl Solution {
    pub fn divide(dividend: i32, divisor: i32) -> i32 {
        if dividend == i32::MIN && divisor == -1 {
            return i32::MAX;
        }
        let (mut a, mut b) = (dividend.abs(), divisor.abs());
        let mut result = 0;
        while a >= b {
            let mut temp = b;
            let mut multiple = 1;
            while a >= (temp << 1) {
                temp <<= 1;
                multiple <<= 1;
            }
            a -= temp;
            result += multiple;
        }
        if (dividend > 0) ^ (divisor > 0) {
            -result
        } else {
            result
        }
    }
}