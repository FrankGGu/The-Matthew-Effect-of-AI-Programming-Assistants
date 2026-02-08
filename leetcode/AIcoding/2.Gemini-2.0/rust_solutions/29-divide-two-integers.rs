impl Solution {
    pub fn divide(dividend: i32, divisor: i32) -> i32 {
        if dividend == i32::MIN && divisor == -1 {
            return i32::MAX;
        }

        let sign = (dividend > 0) ^ (divisor > 0);
        let mut dividend = dividend.abs() as i64;
        let mut divisor = divisor.abs() as i64;

        let mut quotient: i64 = 0;
        while dividend >= divisor {
            let mut temp = divisor;
            let mut multiple: i64 = 1;
            while dividend >= (temp << 1) {
                if temp > i32::MAX as i64 {
                    break;
                }
                temp <<= 1;
                multiple <<= 1;
            }
            dividend -= temp;
            quotient += multiple;
        }

        if sign {
            -quotient as i32
        } else {
            quotient as i32
        }
    }
}