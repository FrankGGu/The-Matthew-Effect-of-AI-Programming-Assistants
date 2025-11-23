impl Solution {
    pub fn convert_to_title(column_number: i32) -> String {
        let mut n = column_number;
        let mut result_chars: Vec<char> = Vec::new();

        while n > 0 {
            n -= 1; 
            let remainder = n % 26;
            result_chars.push((('A' as u8) + (remainder as u8)) as char);
            n /= 26;
        }

        result_chars.into_iter().rev().collect()
    }
}