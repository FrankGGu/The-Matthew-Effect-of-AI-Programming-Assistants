impl Solution {
    pub fn to_hex(num: i32) -> String {
        if num == 0 {
            return "0".to_string();
        }

        let mut n = num as u32;
        let mut result = String::new();

        while n > 0 {
            let digit = n % 16;
            let hex_digit = match digit {
                0..=9 => (digit as u8 + b'0') as char,
                10..=15 => (digit as u8 - 10 + b'a') as char,
                _ => unreachable!(),
            };
            result.push(hex_digit);
            n /= 16;
        }

        result.chars().rev().collect()
    }
}