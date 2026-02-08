impl Solution {
    pub fn divide(dividend: i32, divisor: i32) -> i32 {
        if dividend == i32::MIN && divisor == -1 {
            return i32::MAX;
        }

        let is_negative = (dividend < 0) != (divisor < 0);

        let mut dvd = (dividend as i64).abs();
        let dvs = (divisor as i64).abs();

        let mut res = 0;

        while dvd >= dvs {
            let mut temp_dvs = dvs;
            let mut multiple = 1;
            while dvd >= (temp_dvs << 1) && temp_dvs <= i64::MAX / 2 {
                temp_dvs <<= 1;
                multiple <<= 1;
            }
            dvd -= temp_dvs;
            res += multiple;
        }

        if is_negative {
            -res as i32
        } else {
            res as i32
        }
    }
}