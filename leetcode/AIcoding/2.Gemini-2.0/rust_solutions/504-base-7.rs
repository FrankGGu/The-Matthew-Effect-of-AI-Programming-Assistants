impl Solution {
    pub fn convert_to_base7(num: i32) -> String {
        if num == 0 {
            return "0".to_string();
        }

        let mut n = num.abs();
        let mut result = String::new();

        while n > 0 {
            result.push_str(&(n % 7).to_string());
            n /= 7;
        }

        if num < 0 {
            result.push('-');
        }

        result.chars().rev().collect::<String>()
    }
}