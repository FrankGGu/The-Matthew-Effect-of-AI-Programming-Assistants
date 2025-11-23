impl Solution {
    pub fn divide(dividend: i32, divisor: i32) -> i32 {
        let mut dvd = dividend as i64;
        let mut dvs = divisor as i64;

        let is_negative = (dvd < 0 && dvs > 0) || (dvd > 0 && dvs < 0);

        if dvd > 0 {
            dvd = -dvd;
        }
        if dvs > 0 {
            dvs = -dvs;
        }

        let mut quotient: i64 = 0;

        while dvd <= dvs {
            let mut temp_divisor = dvs;
            let mut multiple: i64 = 1;

            while temp_divisor >= (i64::MIN >> 1) && (temp_divisor << 1) >= dvd {
                temp_divisor <<= 1;
                multiple <<= 1;
            }

            dvd -= temp_divisor;
            quotient += multiple;
        }

        if is_negative {
            quotient = -quotient;
        }

        if quotient > i32::MAX as i64 {
            return i32::MAX;
        }
        if quotient < i32::MIN as i64 {
            return i32::MIN;
        }

        quotient as i32
    }
}