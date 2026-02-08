impl Solution {
    pub fn divide(dividend: i32, divisor: i32) -> i32 {
        if dividend == i32::MIN && divisor == -1 {
            return i32::MAX;
        }
        let sign = if (dividend < 0) ^ (divisor < 0) { -1 } else { 1 };
        let dividend = dividend.abs() as u64;
        let divisor = divisor.abs() as u64;
        let mut quotient = 0;
        let mut temp = 0;
        let mut multiple = 1;

        while temp + divisor <= dividend {
            temp += divisor;
            quotient += multiple;
            multiple <<= 1;
        }

        sign * quotient as i32
    }
}