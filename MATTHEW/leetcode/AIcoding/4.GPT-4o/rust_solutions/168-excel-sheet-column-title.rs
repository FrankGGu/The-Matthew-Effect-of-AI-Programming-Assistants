impl Solution {
    pub fn convert_to_title(column_number: i32) -> String {
        let mut result = String::new();
        let mut num = column_number;
        while num > 0 {
            num -= 1;
            result.push((num % 26 + b'A') as char);
            num /= 26;
        }
        result.chars().rev().collect()
    }
}