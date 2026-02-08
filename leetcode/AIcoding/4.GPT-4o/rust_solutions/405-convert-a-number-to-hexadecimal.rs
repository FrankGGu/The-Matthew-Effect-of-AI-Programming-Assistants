impl Solution {
    pub fn to_hex(num: i32) -> String {
        if num == 0 {
            return "0".to_string();
        }
        let mut n = num as u32;
        let mut hex = String::new();
        while n > 0 {
            let digit = n % 16;
            hex.insert(0, std::char::from_digit(digit, 16).unwrap() );
            n /= 16;
        }
        hex
    }
}