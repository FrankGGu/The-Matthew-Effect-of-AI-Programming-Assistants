impl Solution {
    pub fn divide(dividend: i32, divisor: i32) -> i32 {
        if dividend == i32::MIN && divisor == -1 {
            return i32::MAX;
        }

        let negative = (dividend < 0) != (divisor < 0);
        let mut dividend = if dividend > 0 { -dividend } else { dividend };
        let divisor = if divisor > 0 { -divisor } else { divisor };

        let mut quotient = 0;
        while dividend <= divisor {
            let mut value = divisor;
            let mut power = 1;
            while value >= i32::MIN / 2 && dividend <= value + value {
                value += value;
                power += power;
            }
            dividend -= value;
            quotient += power;
        }

        if negative { -quotient } else { quotient }
    }
}