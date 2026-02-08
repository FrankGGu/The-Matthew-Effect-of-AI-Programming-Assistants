impl Solution {
    pub fn convert_to_title(column_number: i32) -> String {
        let mut n = column_number;
        let mut result = String::new();

        while n > 0 {
            n -= 1;
            let ch = (n % 26) as u8 + b'A';
            result.insert(0, ch as char);
            n /= 26;
        }

        result
    }
}