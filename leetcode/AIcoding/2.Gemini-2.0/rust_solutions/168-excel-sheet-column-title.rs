impl Solution {
    pub fn convert_to_title(mut column_number: i32) -> String {
        let mut result = String::new();
        while column_number > 0 {
            column_number -= 1;
            let remainder = column_number % 26;
            result.push((remainder as u8 + b'A') as char);
            column_number /= 26;
        }
        result.chars().rev().collect()
    }
}