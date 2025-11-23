impl Solution {
    pub fn integer_break(n: i32) -> i32 {
        if n <= 3 {
            return n - 1;
        }
        let quotient = n / 3;
        let remainder = n % 3;
        match remainder {
            0 => 3_i32.pow(quotient),
            1 => 3_i32.pow(quotient - 1) * 4,
            _ => 3_i32.pow(quotient) * 2,
        }
    }
}